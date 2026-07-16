--[[
	VulnLogger.lua
	------------------------------------------------------------
	Analizador estético de seguridad para scripts de Roblox (Lua/Luau).
	Le pasó el CÓDIGO FUENTE como string y te devuelve un reporte
	con las vulnerabilidades/patrones de riesgo encontrados.

	NO ejecuta el código. Solo lo analiza línea por línea buscando
	patrones inseguros conocidos en el desarrollo de Roblox.

	USO:
		local VulnLogger = require(path.to.VulnLogger)
		informe local = VulnLogger.scan(codigoFuente, "NombreDelScript")
		imprimir(informe.texto)

	O desde la Command Bar de Studio, apuntando a un Script/ModuleScript:
		local VulnLogger = require(game.ServerScriptService.VulnLogger)
		local src = script.Parent.Source -- (no accesible en tiempo de ejecución real,
		                                  -- usalo pegando el código a mano)
	------------------------------------------------------------
]]

local VulnLogger = {}

--------------------------------------------------------------
-- Definición de reglas: patrón Lua + severidad + explicación
--------------------------------------------------------------
REGLAS locales = {
	{
		nombre = "loadstring / load dinámico",
		patrón = "cargar%s*%(",
		gravedad = "CRÃ TICA",
		explicó = "Ejecutar código generado dinámicamente (loadstring/load) permite " ..
			"correr lo que sea si un input externo llega a esa cadena. Evitalo o " ..
			"validá exhaustivamente el origen del string.",
	},
	{
		nombre = "getfenv / setfenv",
		patrón = "obtener?fenv%s*%(",
		gravedad = "ALTA",
		explicar = "Manipular el entorno de ejecución puede exponer variables internas " ..
			"o permitir sobreescribir funciones del juego.",
	},
	{
		nombre = "RemoteEvent/RemoteFunction sin validar Player",
		patrón = "OnServerEvent:Connect%s*%(%s*function%s*%(%s*%)",
		gravedad = "CRÃ TICA",
		explicó = "El callback de OnServerEvent no recibe el parámetro 'player'. " ..
			"Sin ese parámetro no podés verificar quién disparó el evento, lo que " ..
			"facilita spoofing/exploits desde el cliente.",
	},
	{
		name = "Confiar en datos del cliente sin sanear",
		patrón = "OnServerEvent:Connect",
		gravedad = "MEDIA",
		explicó = "Se encontró un RemoteEvent/RemoteFunction conectado en el servidor." ..
			"Revisá manualmente que TODOS los argumentos recibidos del cliente se " ..
			"validen (tipo, rango, pertenencia) antes de usarlos (ej: dar Ãtems, " ..
			"modificar moneda, teletransportar).",
	},
	{
		name="_G/shared usados ​​para datos sensibles",
		patrón = "_G%",
		gravedad = "MEDIA",
		explicó = "_G es una tabla global compartida entre TODOS los scripts del mismo " ..
			"contexto (incluso plugins/otros módulos). No la uses para flags de admin, " ..
			"claves o datos de sesión.",
	},
	{
		nombre = "Posible puerta trasera / lista blanca de administradores codificada",
		patrón = "UserId%s*==%s*%d+",
		gravedad = "ALTA",
		explicó = "UserIds de administradores codificados en el código son fáciles de " ..
			"Encontrar si el script se filtra o se descompila. Prefiere un DataStore o " ..
			"un rol gestionado externamente, y nunca en un LocalScript.",
	},
	{
		nombre = "DataStore sin pcall",
		patrón = "DataStoreService",
		gravedad = "MEDIA",
		explicó = "Se usa DataStoreService. Verifica que TODAS las llamadas " ..
			"(GetAsync/SetAsync/UpdateAsync) están envueltas en pcall — si no, un " ..
			"error de red puede corromper datos o tirar el script del servidor sin control.",
	},
	{
		name = "require() de un módulo con ID numérico externo",
		patrón = "requiere%s*%(%s*%d+%s*%)",
		gravedad = "ALTA",
		explicó = "Estás requireando un Asset por ID numérico (no un objeto del juego). " ..
			"Si ese activo lo controla otra persona, puede inyectar código arbitrario " ..
			"en tu experiencia.",
	},
	{
		name = "Lógica sensible en LocalScript",
		patrón = "leaderstats%.[%w_]+%.Value%s*=",
		gravedad = "CRÃ TICA",
		explicó = "Se modifica un valor de leaderstats (moneda/progreso) directamente." ..
			"Si esta línea está en un LocalScript, un exploit del cliente puede " ..
			"asignarse cualquier valor. Esta lógica DEBE vivir en el servidor.",
	},
	{
		nombre = "HttpService con URL codificada",
		patrón = "HttpService.-GetAsync%s*%(%s*[\"']http",
		gravedad = "MEDIA",
		explica = "Llamadas HTTP a URL fijas: verifica que no sea un endpoint que " ..
			"filtre datos de jugadores (IP, UserId, etc.) a un tercero sin que el " ..
			"jugador lo sabe.",
	},
	{
		name = "WaitForChild con timeout infinito en crítico remoto",
		patrón = "WaitForChild%s*%([\"'][%w_]*[Rr]emote",
		gravedad = "BAJA",
		explicó = "Esperar un RemoteEvent/Function sin tiempo de espera puede colgar el script " ..
			"si el objeto nunca aparece (uso normal, pero vale la pena revisar).",
	},
}

--------------------------------------------------------------
-- Utilidad: severidad â†' peso para ordenar
--------------------------------------------------------------
local SEVERITY_WEIGHT = { ["CRÍTICA"] = 4, ["ALTA"] = 3, ["MEDIA"] = 2, ["BAJA"] = 1 }

--------------------------------------------------------------
-- Escanea el código fuente y arma el reporte
--------------------------------------------------------------
función VulnLogger.scan(sourceCode, scriptName)
	afirmar(type(sourceCode) == "string", "sourceCode debe ser un string con el código a analizar")
	scriptName = scriptName o "Script"

	hallazgos locales = {}
	número de línea local = 0

	para línea en (sourceCode .. "\n"):gmatch("(.-)\n") hacer
		número de línea += 1
		para _, regla en ipairs(REGLAS) hacer
			si línea:coincide(regla.patrón) entonces
				tabla.insertar(hallazgos, {
					línea = número de línea,
					código = línea:gsub("^%s+", ""),
					nombre = regla.nombre,
					gravedad = regla.gravedad,
					explicar = regla.explicar,
				})
			fin
		fin
	fin

	tabla.ordenar(hallazgos, función(a, b)
		devolver SEVERITY_WEIGHT[a.severity] > SEVERITY_WEIGHT[b.severity]
	fin)

	-- Armar texto legible del log
	líneas locales = {}
	table.insert(lines, ("== VulnLogger :: informe de %s =="):format(scriptName))
	tabla.insertar(líneas, ("Hallazgos: %d"):formato(#hallazgos))
	tabla.insertar(líneas, "")

	si #hallazgos == 0 entonces
		table.insert(lines, "No se detectaron patrones de riesgo conocidos. " ..
			"Esto NO garantiza que el script sea 100%% seguro: revisa también" ..
			"la lógica de negocio a mano.")
	demás
		para _, f en ipairs(hallazgos) hacer
			tabla.insertar(líneas, ("[%s] línea %d — %s"):formato(f.gravedad, f.línea, f.nombre))
			tabla.insertar(líneas, ("código: %s"):formato(f.código))
			tabla.insertar(líneas, (" por qué: %s"):formato(f.explain))
			tabla.insertar(líneas, "")
		fin
	fin

	devolver {
		scriptName = scriptName,
		hallazgos = hallazgos,
		texto = tabla.concat(líneas, "\n"),
	}
fin

--------------------------------------------------------------
-- Ayudante: escanear varios scripts de una sola vez
-- entrada: { {nombre="Servidor1", fuente="..."}, {nombre="Cliente1", fuente="..."} }
--------------------------------------------------------------
función VulnLogger.scanMultiple(scripts)
	informes locales = {}
	totalhallings local = 0
	para _, s en ipairs(scripts) hacer
		local r = VulnLogger.scan(s.source, s.name)
		tabla.insertar(informes, r)
		totalHallazgos += #r.hallazgos
	fin
	informes de retorno, hallazgos totales
fin

devolver VulnLogger
