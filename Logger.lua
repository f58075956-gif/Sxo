-- ============================================================
-- ATTACK MONITOR: detecta cuando te pegan, identifica quiÃ©n fue
-- (por el ultimo jugador que te toco antes de perder Durability)
-- y lo manda a Discord con hora exacta.
-- ============================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- PegÃ¡ acÃ¡ tu webhook de Discord (ConfiguraciÃ³n del canal > Integraciones
-- > Webhooks > Crear webhook > Copiar URL)
local DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1525355799507894353/sy5CZdC_fgNXGs79tbDDMI-8jd1M_ZIB4rwsbku3g4zbKRxblJ35iju3bt4J3kMeDNGg"

-- Ventana de tiempo (segundos) para considerar que un toque reciente fue
-- el causante de la baja de Durability. Ajustable si ves falsos positivos.
local ATTACK_WINDOW = 1.5

local recentTouches = {} -- [playerName] = tick() del ultimo toque

local monitorOn = false
local connections = {}

local function sendDiscordLog(attackerName, damage, currentDurability)
	if DISCORD_WEBHOOK_URL == "PEGA_TU_WEBHOOK_ACA" then
		warn("[AttackMonitor] Falta configurar DISCORD_WEBHOOK_URL")
		return
	end

	local payload = {
		embeds = {
			{
				title = "âš”ï¸ Te pegaron",
				color = 16729156, -- rojo
				fields = {
					{ name = "Atacante", value = attackerName, inline = true },
					{ name = "DaÃ±o estimado", value = tostring(damage), inline = true },
					{ name = "Durability restante", value = tostring(currentDurability), inline = true },
					{ name = "Hora", value = os.date("%d/%m/%Y %H:%M:%S"), inline = false },
				},
			},
		},
	}

	local body = HttpService:JSONEncode(payload)

	local ok, err = pcall(function()
		local requestFn = (syn and syn.request) or (http and http.request) or http_request or request
		requestFn({
			Url = DISCORD_WEBHOOK_URL,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = body,
		})
	end)

	if not ok then
		warn("[AttackMonitor] Error mandando el webhook: " .. tostring(err))
	end
end

local function registerTouch(otherPlayer)
	if otherPlayer and otherPlayer ~= player then
		recentTouches[otherPlayer.Name] = tick()
	end
end

local function findLikelyAttacker()
	local bestName, bestTime = nil, 0
	local now = tick()

	for name, touchTime in pairs(recentTouches) do
		if now - touchTime <= ATTACK_WINDOW and touchTime > bestTime then
			bestName = name
			bestTime = touchTime
		end
	end

	return bestName -- nil si nadie real te tocÃ³ (ej: entrenando con la roca)
end

local function hookCharacter(character)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			local conn = part.Touched:Connect(function(hit)
				local hitCharacter = hit:FindFirstAncestorOfClass("Model")
				local hitPlayer = hitCharacter and Players:GetPlayerFromCharacter(hitCharacter)
				registerTouch(hitPlayer)
			end)
			table.insert(connections, conn)
		end
	end

	table.insert(connections, character.DescendantAdded:Connect(function(part)
		if part:IsA("BasePart") then
			local conn = part.Touched:Connect(function(hit)
				local hitCharacter = hit:FindFirstAncestorOfClass("Model")
				local hitPlayer = hitCharacter and Players:GetPlayerFromCharacter(hitCharacter)
				registerTouch(hitPlayer)
			end)
			table.insert(connections, conn)
		end
	end))
end

local function startMonitor()
	local durabilityStat = player:WaitForChild("Durability")
	local lastValue = durabilityStat.Value

	local conn = durabilityStat:GetPropertyChangedSignal("Value"):Connect(function()
		local newValue = durabilityStat.Value
		local delta = newValue - lastValue

		if delta < 0 then
			local damage = -delta
			local attacker = findLikelyAttacker()
			if attacker then
				sendDiscordLog(attacker, damage, newValue)
			end
			-- Si attacker es nil, lo mÃ¡s probable es que la baja de
			-- Durability sea por entrenar (roca/dummy), no por otro
			-- jugador, asÃ­ que no mandamos nada a Discord.
		end

		lastValue = newValue
	end)
	table.insert(connections, conn)

	if player.Character then
		hookCharacter(player.Character)
	end
	table.insert(connections, player.CharacterAdded:Connect(hookCharacter))
end

local function stopMonitor()
	for _, conn in ipairs(connections) do
		conn:Disconnect()
	end
	connections = {}
	recentTouches = {}
end

-- --- Arranca solo, apenas corre el script, y queda permanente ---
startMonitor()
monitorOn = true

-- Si en algÃºn momento querÃ©s poder apagarlo/prenderlo a mano desde la UI,
-- colgÃ¡ este switch donde tengas el resto de tus tabs/folders (opcional,
-- el monitor ya funciona sin esto):
-- Folderfarming:AddSwitch("Attack Monitor -> Discord", function(state)
-- 	monitorOn = state
-- 	if state then
-- 		startMonitor()
-- 	else
-- 		stopMonitor()
-- 	end
-- end)
