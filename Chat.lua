-- â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
-- â•‘           LOCAL CHAT - Nexo                  â•‘
-- â•‘  SaveManager + Rangos + Comandos + @Mencionesâ•‘
-- â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local HttpService      = game:GetService("HttpService")

local lplr      = Players.LocalPlayer
local playerGui = lplr:WaitForChild("PlayerGui")

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  SAVE MANAGER
--  Todos los datos usan UserId como clave (string)
--  para que los apodos/DisplayNames no interfieran
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local SaveManager = {} do
    SaveManager.Folder    = "NexoLocalChat"
    SaveManager.File      = SaveManager.Folder .. "/settings.json"
    SaveManager.RanksFile = SaveManager.Folder .. "/ranks.json"
    SaveManager.BansFile  = SaveManager.Folder .. "/bans.json"
    SaveManager.MutesFile = SaveManager.Folder .. "/mutes.json"

    SaveManager.Defaults = {
        WindowPosX     = 10,
        WindowPosY     = 120,
        WindowW        = 380,
        WindowH        = 300,
        MaxMessages    = 50,
        AccentColorHex = "7850FF",
        Minimized      = false,
    }

    function SaveManager:BuildFolder()
        if not isfolder(self.Folder) then makefolder(self.Folder) end
    end

    function SaveManager:SaveTable(file, data)
        self:BuildFolder()
        local ok, encoded = pcall(HttpService.JSONEncode, HttpService, data)
        if ok then writefile(file, encoded) end
    end

    function SaveManager:LoadTable(file)
        self:BuildFolder()
        if not isfile(file) then return {} end
        local ok, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(file))
        return ok and decoded or {}
    end

    function SaveManager:Save(data)   self:SaveTable(self.File, data) end
    function SaveManager:Load()
        local d = self:LoadTable(self.File)
        for k, v in pairs(self.Defaults) do
            if d[k] == nil then d[k] = v end
        end
        return d
    end

    SaveManager:BuildFolder()
end

local cfg = SaveManager:Load()

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  OWNER HARDCODED
--  KARMAXJOHAN tiene nivel 4 (super-owner).
--  Su rango no se puede quitar ni sobreescribir.
--  Se identifica por username (Name), no por UserId,
--  porque el UserId no se conoce de antemano.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local HARDCODED_OWNER_NAME = "KARMAXJOHAN"   -- username exacto de Roblox

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  RANGOS  â€”  clave: tostring(userId)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local RANK_INFO = {
    superowner = { label = "[OWNER]", color = Color3.fromRGB(255, 215, 0), level = 4 },
    owner      = { label = "[OWNER]", color = Color3.fromRGB(255, 215, 0), level = 3 },
    admin      = { label = "[ADMIN]", color = Color3.fromRGB(255,  80, 80), level = 2 },
    mod        = { label = "[MOD]",   color = Color3.fromRGB( 80, 200,120), level = 1 },
}

local ranks = SaveManager:LoadTable(SaveManager.RanksFile)

local function saveRanks() SaveManager:SaveTable(SaveManager.RanksFile, ranks) end

-- Devuelve el rango efectivo: si es el superowner hardcoded, siempre "superowner"
local function getRank(uid)
    -- Buscar si el uid corresponde al hardcoded owner por username
    local p = Players:GetPlayerByUserId(tonumber(uid) or 0)
    if p and p.Name == HARDCODED_OWNER_NAME then
        return "superowner"
    end
    -- TambiÃ©n checar si el LocalPlayer mismo es el owner (antes de unirse a la tabla)
    if lplr and lplr.Name == HARDCODED_OWNER_NAME and tostring(lplr.UserId) == tostring(uid) then
        return "superowner"
    end
    return ranks[tostring(uid)]
end

local function getRankLevel(uid)
    local r = getRank(uid)
    return r and RANK_INFO[r] and RANK_INFO[r].level or 0
end

-- Asignar superowner al LocalPlayer si es KARMAXJOHAN
local function applySuperOwnerIfNeeded()
    if lplr.Name == HARDCODED_OWNER_NAME then
        -- No necesita guardarse; getRank() lo detecta por username
        -- Pero lo dejamos en ranks para que setrank lo sepa
        ranks[tostring(lplr.UserId)] = "superowner"
        saveRanks()
    end
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  BANS  â€”  clave: tostring(userId)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local bans = SaveManager:LoadTable(SaveManager.BansFile)

local function saveBans() SaveManager:SaveTable(SaveManager.BansFile, bans) end
local function isBanned(uid)
    local e = bans[tostring(uid)]
    if not e then return false end
    if e.expiry and os.time() > e.expiry then
        bans[tostring(uid)] = nil; saveBans(); return false
    end
    return true
end

-- Si el LocalPlayer estÃ¡ banneado, no dejamos que cargue el script
if isBanned(lplr.UserId) then
    lplr:Kick("Lo sentimos, no puedes usar el script.")
    do return end
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  MUTES  â€”  clave: tostring(userId)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local mutes = SaveManager:LoadTable(SaveManager.MutesFile)

local function saveMutes() SaveManager:SaveTable(SaveManager.MutesFile, mutes) end
local function isMuted(uid)
    local e = mutes[tostring(uid)]
    if not e then return false end
    if e.expiry and os.time() > e.expiry then
        mutes[tostring(uid)] = nil; saveMutes(); return false
    end
    return true
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  UTILIDADES
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local function parseDuration(str)
    if not str then return nil end
    str = str:lower()
    if str == "perm" or str == "permanente" then return nil end
    local n, unit = str:match("^(%d+)(.+)$")
    if not n then return nil end
    n = tonumber(n)
    if     unit == "s"               then return n
    elseif unit == "min" or unit == "m" then return n * 60
    elseif unit == "h"               then return n * 3600
    elseif unit == "dia" or unit == "d" then return n * 86400
    elseif unit == "sem"             then return n * 604800
    end
    return nil
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  USUARIOS DEL SCRIPT
--  Solo cuentan como "usuarios" los jugadores que
--  han enviado al menos un mensaje por este chat.
--  AsÃ­ el autocompletado de @menciones no incluye
--  a jugadores que no tienen el script cargado.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local scriptUsers = {}
scriptUsers[tostring(lplr.UserId)] = true -- yo mismo uso el script

-- Busca jugador por DisplayName o Name (parcial, insensible)
local function findPlayer(query)
    query = query:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.DisplayName:lower():find(query, 1, true)
        or p.Name:lower():find(query, 1, true) then
            return p
        end
    end
    return nil
end

-- Devuelve lista de DisplayNames de jugadores que empiezan con prefix
-- Solo incluye jugadores que usan el script (scriptUsers)
local function getDisplayMatches(prefix)
    prefix = prefix:lower()
    local out = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if scriptUsers[tostring(p.UserId)]
        and p.DisplayName:lower():sub(1, #prefix) == prefix then
            table.insert(out, p.DisplayName)
        end
    end
    return out
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  CONFIG RUNTIME
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local CONFIG = {
    MaxMessages  = cfg.MaxMessages,
    ChatKey      = Enum.KeyCode.Return,
    WindowSize   = UDim2.new(0, cfg.WindowW,  0, cfg.WindowH),
    WindowPos    = UDim2.new(0, cfg.WindowPosX, 0, cfg.WindowPosY),
    BubbleColor  = Color3.fromRGB(20, 20, 28),
    AccentColor  = Color3.fromHex(cfg.AccentColorHex),
    SelfColor    = Color3.fromRGB(80, 60, 180),
    TextColor    = Color3.fromRGB(235, 235, 240),
    SubTextColor = Color3.fromRGB(140, 140, 160),
    MentionColor = Color3.fromRGB(120, 180, 255),
    BorderColor  = Color3.fromRGB(60, 50, 90),
    InputBg      = Color3.fromRGB(14, 14, 20),
    ChatTag      = "[LOCAL]",
}

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  GUI  â€”  ScreenGui + MainFrame
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "NexoLocalChat"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local guiParent = (typeof(gethui) == "function" and gethui()) or playerGui
ScreenGui.DisplayOrder   = 999
ScreenGui.Parent         = guiParent

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name             = "MainFrame"
MainFrame.Size             = CONFIG.WindowSize
MainFrame.Position         = CONFIG.WindowPos
MainFrame.BackgroundColor3 = CONFIG.BubbleColor
MainFrame.BorderSizePixel  = 0
MainFrame.ClipsDescendants = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local _stroke = Instance.new("UIStroke", MainFrame)
_stroke.Color = CONFIG.BorderColor; _stroke.Thickness = 1.5

-- TopBar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Name = "TopBar"; TopBar.Size = UDim2.new(1,0,0,32)
TopBar.BackgroundColor3 = Color3.fromRGB(14,10,24); TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0,12)
local _tbfix = Instance.new("Frame", TopBar)
_tbfix.Size = UDim2.new(1,0,0.5,0); _tbfix.Position = UDim2.new(0,0,0.5,0)
_tbfix.BackgroundColor3 = Color3.fromRGB(14,10,24)
_tbfix.BorderSizePixel = 0; _tbfix.ZIndex = 0; _tbfix.Active = false

local AccentDot = Instance.new("Frame", TopBar)
AccentDot.Size = UDim2.new(0,8,0,8); AccentDot.Position = UDim2.new(0,10,0.5,-4)
AccentDot.BackgroundColor3 = CONFIG.AccentColor; AccentDot.BorderSizePixel = 0
Instance.new("UICorner", AccentDot).CornerRadius = UDim.new(1,0)

local TitleLabel = Instance.new("TextLabel", TopBar)
TitleLabel.Size = UDim2.new(1,-60,1,0); TitleLabel.Position = UDim2.new(0,24,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Chat Local  â€¢  " .. #Players:GetPlayers() .. " jugadores"
TitleLabel.TextColor3 = CONFIG.TextColor; TitleLabel.TextSize = 12
TitleLabel.Font = Enum.Font.GothamMedium
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0,26,0,18); MinBtn.Position = UDim2.new(1,-30,0.5,-9)
MinBtn.BackgroundColor3 = Color3.fromRGB(40,30,60); MinBtn.Text = "â€”"
MinBtn.TextColor3 = CONFIG.SubTextColor; MinBtn.TextSize = 11
MinBtn.Font = Enum.Font.GothamBold; MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0,4)

-- ScrollFrame (mensajes)
local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Name = "ScrollFrame"; ScrollFrame.Size = UDim2.new(1,-8,1,-80)
ScrollFrame.Position = UDim2.new(0,4,0,36); ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0; ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = CONFIG.AccentColor
ScrollFrame.CanvasSize = UDim2.new(0,0,0,0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollFrame.ScrollingEnabled = true; ScrollFrame.Active = true
local ListLayout = Instance.new("UIListLayout", ScrollFrame)
ListLayout.Padding = UDim.new(0,4); ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
local ListPadding = Instance.new("UIPadding", ScrollFrame)
ListPadding.PaddingLeft = UDim.new(0,4); ListPadding.PaddingRight = UDim.new(0,4)
ListPadding.PaddingTop = UDim.new(0,4)

-- InputFrame
local InputFrame = Instance.new("Frame", MainFrame)
InputFrame.Name = "InputFrame"; InputFrame.Size = UDim2.new(1,-12,0,36)
InputFrame.Position = UDim2.new(0,6,1,-42)
InputFrame.BackgroundColor3 = CONFIG.InputBg; InputFrame.BorderSizePixel = 0
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0,8)
local _istroke = Instance.new("UIStroke", InputFrame)
_istroke.Color = CONFIG.BorderColor; _istroke.Thickness = 1

local ChatInput = Instance.new("TextBox", InputFrame)
ChatInput.Size = UDim2.new(1,-50,1,0); ChatInput.Position = UDim2.new(0,8,0,0)
ChatInput.BackgroundTransparency = 1
ChatInput.PlaceholderText = "Escribe, @ para mencionar, /ayuda..."
ChatInput.PlaceholderColor3 = CONFIG.SubTextColor; ChatInput.Text = ""
ChatInput.TextColor3 = CONFIG.TextColor; ChatInput.TextSize = 13
ChatInput.Font = Enum.Font.Gotham
ChatInput.TextXAlignment = Enum.TextXAlignment.Left
ChatInput.ClearTextOnFocus = false

-- Bloquea/desbloquea el cuadro de texto segÃºn el estado de muteo
local function applyMuteState()
    if isMuted(lplr.UserId) then
        ChatInput.Text = ""
        ChatInput.TextEditable = false
        ChatInput.PlaceholderText = "EstÃ¡s muteado, no puedes escribir."
    else
        ChatInput.TextEditable = true
        ChatInput.PlaceholderText = "Escribe, @ para mencionar, /ayuda..."
    end
end
applyMuteState()

local SendBtn = Instance.new("TextButton", InputFrame)
SendBtn.Size = UDim2.new(0,36,0,26); SendBtn.Position = UDim2.new(1,-40,0.5,-13)
SendBtn.BackgroundColor3 = CONFIG.AccentColor; SendBtn.Text = "â†‘"
SendBtn.TextColor3 = Color3.fromRGB(255,255,255); SendBtn.TextSize = 16
SendBtn.Font = Enum.Font.GothamBold; SendBtn.BorderSizePixel = 0
Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0,6)

local TagLabel = Instance.new("TextLabel", MainFrame)
TagLabel.Size = UDim2.new(0,60,0,14); TagLabel.Position = UDim2.new(0,6,1,-14)
TagLabel.BackgroundTransparency = 1; TagLabel.Text = CONFIG.ChatTag
TagLabel.TextColor3 = CONFIG.AccentColor; TagLabel.TextSize = 10
TagLabel.Font = Enum.Font.GothamBold
TagLabel.TextXAlignment = Enum.TextXAlignment.Left

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  POPUP DE @MENCIONES (autocompletado)
--  Aparece justo encima del InputFrame
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local MentionPopup = Instance.new("Frame", MainFrame)
MentionPopup.Name             = "MentionPopup"
MentionPopup.Size             = UDim2.new(1,-12,0,0)   -- altura dinÃ¡mica
MentionPopup.Position         = UDim2.new(0,6,1,-42)   -- se ajusta encima del input
MentionPopup.BackgroundColor3 = Color3.fromRGB(18,14,30)
MentionPopup.BorderSizePixel  = 0
MentionPopup.Visible          = false
MentionPopup.ZIndex           = 10
MentionPopup.ClipsDescendants = true
Instance.new("UICorner", MentionPopup).CornerRadius = UDim.new(0,8)
local _mpstroke = Instance.new("UIStroke", MentionPopup)
_mpstroke.Color = CONFIG.AccentColor; _mpstroke.Thickness = 1

local MentionList = Instance.new("UIListLayout", MentionPopup)
MentionList.Padding = UDim.new(0,2); MentionList.SortOrder = Enum.SortOrder.LayoutOrder
local MentionPad = Instance.new("UIPadding", MentionPopup)
MentionPad.PaddingLeft = UDim.new(0,4); MentionPad.PaddingRight = UDim.new(0,4)
MentionPad.PaddingTop = UDim.new(0,4); MentionPad.PaddingBottom = UDim.new(0,4)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  LÃ“GICA PRINCIPAL
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local messageCount = 0
local minimized    = cfg.Minimized
local originalSize = CONFIG.WindowSize

local function persistConfig()
    local pos  = MainFrame.Position
    local size = MainFrame.Size
    SaveManager:Save({
        WindowPosX     = pos.X.Offset,
        WindowPosY     = pos.Y.Offset,
        WindowW        = size.X.Offset,
        WindowH        = size.Y.Offset,
        MaxMessages    = CONFIG.MaxMessages,
        AccentColorHex = cfg.AccentColorHex,
        Minimized      = minimized,
    })
end

local function scrollToBottom()
    task.defer(function()
        ScrollFrame.CanvasPosition = Vector2.new(0, ScrollFrame.AbsoluteCanvasSize.Y)
    end)
end

-- Renderiza el texto resaltando @DisplayName en azul
-- Devuelve un Frame contenedor con partes de texto
local function buildTextWithMentions(parent, text, baseColor, baseSize, baseFont, posY, widthOffset)
    -- Dividir texto en partes: normal y @menciÃ³n
    local parts = {}
    local i = 1
    while i <= #text do
        local at = text:find("@", i, true)
        if not at then
            table.insert(parts, { str = text:sub(i), mention = false })
            break
        end
        if at > i then
            table.insert(parts, { str = text:sub(i, at-1), mention = false })
        end
        -- Capturar la menciÃ³n: letras, nÃºmeros y guiones bajos/espacios hasta el primer espacio real
        local mentionEnd = at
        local j = at + 1
        while j <= #text and text:sub(j,j) ~= " " do
            j = j + 1
        end
        table.insert(parts, { str = text:sub(at, j-1), mention = true })
        i = j
    end

    -- Crear un Frame horizontal con las partes
    local Container = Instance.new("Frame", parent)
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1, widthOffset or -42, 0, baseSize + 4)
    Container.Position = UDim2.new(0, 40, 0, posY)
    Container.ClipsDescendants = false

    -- Usamos un solo TextLabel con RichText si estÃ¡ disponible,
    -- o fallback a texto plano con marcadores visuales
    local richText = ""
    for _, part in ipairs(parts) do
        if part.mention then
            -- azul claro para @menciones
            richText = richText .. '<font color="rgb(120,180,255)"><b>' .. part.str .. '</b></font>'
        else
            richText = richText .. part.str
        end
    end

    local Lbl = Instance.new("TextLabel", Container)
    Lbl.Size = UDim2.new(1,0,1,0)
    Lbl.BackgroundTransparency = 1
    Lbl.RichText = true
    Lbl.Text = richText
    Lbl.TextColor3 = baseColor
    Lbl.TextSize = baseSize
    Lbl.Font = baseFont
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true

    return Container
end

-- FunciÃ³n principal de aÃ±adir mensaje
local function addMessage(playerName, userId, text, isSelf, rankKey, isSystem)
    messageCount += 1
    if messageCount > CONFIG.MaxMessages then
        local first = ScrollFrame:FindFirstChildWhichIsA("Frame")
        if first then first:Destroy() end
        messageCount -= 1
    end

    local bgColor
    if isSystem       then bgColor = Color3.fromRGB(15,15,30)
    elseif isSelf     then bgColor = CONFIG.SelfColor
    else                   bgColor = Color3.fromRGB(28,24,40) end

    -- Â¿El mensaje me menciona? (resaltar borde)
    local mentionsMe = text:lower():find("@" .. lplr.DisplayName:lower(), 1, true) ~= nil

    local MsgFrame = Instance.new("Frame", ScrollFrame)
    MsgFrame.Name = "Msg_" .. messageCount
    MsgFrame.Size = UDim2.new(1,0,0,48)
    MsgFrame.BackgroundColor3 = bgColor
    MsgFrame.BorderSizePixel = 0
    MsgFrame.LayoutOrder = messageCount
    Instance.new("UICorner", MsgFrame).CornerRadius = UDim.new(0,8)

    if mentionsMe and not isSelf then
        local ms = Instance.new("UIStroke", MsgFrame)
        ms.Color = CONFIG.MentionColor; ms.Thickness = 1.2
    end

    local MP = Instance.new("UIPadding", MsgFrame)
    MP.PaddingLeft = UDim.new(0,6); MP.PaddingRight = UDim.new(0,6)
    MP.PaddingTop = UDim.new(0,6); MP.PaddingBottom = UDim.new(0,6)

    -- Avatar
    local Avatar = Instance.new("ImageLabel", MsgFrame)
    Avatar.Size = UDim2.new(0,32,0,32); Avatar.Position = UDim2.new(0,0,0,0)
    Avatar.BackgroundColor3 = Color3.fromRGB(40,35,55); Avatar.BorderSizePixel = 0
    if isSystem then
        Avatar.Image = "rbxassetid://7733960981"
        Avatar.BackgroundColor3 = Color3.fromRGB(30,20,50)
    else
        Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="
            .. userId .. "&width=48&height=48&format=png"
    end
    Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1,0)

    -- Badge de rango
    local nameOffX = 40
    if rankKey and RANK_INFO[rankKey] then
        local info = RANK_INFO[rankKey]
        local Badge = Instance.new("TextLabel", MsgFrame)
        Badge.BackgroundColor3 = info.color; Badge.BackgroundTransparency = 0.55
        Badge.Text = info.label; Badge.TextColor3 = Color3.fromRGB(255,255,255)
        Badge.TextSize = 9; Badge.Font = Enum.Font.GothamBold
        Badge.BorderSizePixel = 0
        Badge.Size = UDim2.new(0,52,0,13); Badge.Position = UDim2.new(0,nameOffX,0,0)
        Instance.new("UICorner", Badge).CornerRadius = UDim.new(0,4)
        nameOffX = nameOffX + 56
    end

    -- Nombre (DisplayName)
    local NameLabel = Instance.new("TextLabel", MsgFrame)
    NameLabel.Size = UDim2.new(1,-nameOffX,0,14)
    NameLabel.Position = UDim2.new(0,nameOffX,0,0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = playerName   -- siempre DisplayName
    NameLabel.TextColor3 = isSystem and CONFIG.AccentColor
        or (isSelf and Color3.fromRGB(200,180,255) or CONFIG.SubTextColor)
    NameLabel.TextSize = 10; NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Calcular altura del texto
    local charsPerLine = math.floor((340 - 42 - 12) / 8)
    local lines = math.max(1, math.ceil(#text / charsPerLine))
    local textHeight = lines * 16
    local totalHeight = math.max(48, 6 + 14 + 4 + textHeight + 6)
    MsgFrame.Size = UDim2.new(1,0,0,totalHeight)

    -- Texto con menciones resaltadas en azul (RichText)
    buildTextWithMentions(MsgFrame, text, CONFIG.TextColor, 13, Enum.Font.Gotham, 16, -42)

    MsgFrame.BackgroundTransparency = 1
    TweenService:Create(MsgFrame, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    scrollToBottom()
end

local function sysMsg(text)
    addMessage("Sistema", 0, text, false, nil, true)
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  POPUP DE MENCIONES  â€” lÃ³gica
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local activeMentionPrefix = nil   -- string sin "@", nil = popup cerrado

local function closeMentionPopup()
    MentionPopup.Visible = false
    activeMentionPrefix = nil
    for _, c in ipairs(MentionPopup:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
end

local function openMentionPopup(matches)
    -- Limpiar botones anteriores
    for _, c in ipairs(MentionPopup:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end

    if #matches == 0 then closeMentionPopup(); return end

    local btnH = 24
    local totalH = btnH * #matches + 8

    for idx, displayName in ipairs(matches) do
        local Btn = Instance.new("TextButton", MentionPopup)
        Btn.Name = "MentionBtn_" .. idx
        Btn.Size = UDim2.new(1,0,0,btnH)
        Btn.BackgroundColor3 = Color3.fromRGB(30,22,50)
        Btn.BackgroundTransparency = 0.2
        Btn.BorderSizePixel = 0
        Btn.Text = "@" .. displayName
        Btn.TextColor3 = CONFIG.MentionColor
        Btn.TextSize = 12; Btn.Font = Enum.Font.GothamMedium
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)
        local BtnPad = Instance.new("UIPadding", Btn)
        BtnPad.PaddingLeft = UDim.new(0,8)
        Btn.LayoutOrder = idx

        Btn.MouseButton1Click:Connect(function()
            -- Reemplazar el @prefix parcial por @DisplayName completo
            local currentText = ChatInput.Text
            -- Buscar la Ãºltima @ en el texto
            local lastAt = currentText:match(".*()@") -- posiciÃ³n del Ãºltimo @
            if lastAt then
                ChatInput.Text = currentText:sub(1, lastAt) .. displayName .. " "
                -- Mover cursor al final
                ChatInput.CursorPosition = #ChatInput.Text + 1
            end
            closeMentionPopup()
            ChatInput:CaptureFocus()
        end)
    end

    -- PosiciÃ³n: encima del InputFrame
    MentionPopup.Size = UDim2.new(1,-12,0,totalH)
    MentionPopup.Position = UDim2.new(0,6,1,-(42 + totalH + 4))
    MentionPopup.Visible = true
end

-- Detectar @ en el input mientras el usuario escribe
ChatInput:GetPropertyChangedSignal("Text"):Connect(function()
    local text = ChatInput.Text
    -- Encontrar el Ãºltimo segmento @palabra sin espacios
    local prefix = text:match("@([^@%s]*)$")
    if prefix ~= nil then
        activeMentionPrefix = prefix
        local matches = getDisplayMatches(prefix)
        openMentionPopup(matches)
    else
        closeMentionPopup()
    end
end)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  COMANDOS
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local COMMANDS = {}

COMMANDS["ayuda"] = {
    minLevel = 0,
    run = function()
        local lv = getRankLevel(lplr.UserId)
        local L = { "â”€â”€ Comandos disponibles â”€â”€" }
        table.insert(L, "@DisplayName  â€”  mencionar un jugador")
        if lv >= 1 then
            table.insert(L, "/mute <apodo> <tiempo|perm>")
            table.insert(L, "/unmute <apodo>")
            table.insert(L, "/clear")
        end
        if lv >= 2 then
            table.insert(L, "/ban <userId> <tiempo|perm>")
            table.insert(L, "/unban <apodo>")
            table.insert(L, "/unban_id <userId>")
            table.insert(L, "/setrank <apodo> <mod|admin|none>")
        end
        if lv >= 3 then
            table.insert(L, "/setrank <apodo> owner")
        end
        if lv == 0 then table.insert(L, "(sin permisos especiales)") end
        for _, l in ipairs(L) do sysMsg(l) end
    end,
}

COMMANDS["clear"] = {
    minLevel = 1,
    run = function()
        for _, c in ipairs(ScrollFrame:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        messageCount = 0
        sysMsg("Chat limpiado por " .. lplr.DisplayName .. ".")
        if shared.nexoLocalChatEvent then
            shared.nexoLocalChatEvent:Fire("__CMD__","__CMD__",0,"CLEAR:"..lplr.Name)
        end
    end,
}

COMMANDS["mute"] = {
    minLevel = 1,
    run = function(args)
        local tName, durStr = args[1], args[2]
        if not tName then sysMsg("Uso: /mute <apodo> <tiempo|perm>") return end
        local t = findPlayer(tName)
        if not t then sysMsg("Jugador '" .. tName .. "' no encontrado.") return end
        if getRankLevel(t.UserId) >= getRankLevel(lplr.UserId) then
            sysMsg("No puedes mutear a alguien de igual o mayor rango.") return
        end
        local secs   = parseDuration(durStr or "perm")
        local expiry = secs and (os.time() + secs) or nil
        mutes[tostring(t.UserId)] = { expiry = expiry }
        saveMutes()
        sysMsg(t.DisplayName .. " muteado (" .. (expiry and durStr or "permanente") .. ") por " .. lplr.DisplayName .. ".")
        if shared.nexoLocalChatEvent then
            shared.nexoLocalChatEvent:Fire("__CMD__","__CMD__",0,"MUTE:"..t.UserId..":"..tostring(expiry or "nil"))
        end
    end,
}

COMMANDS["unmute"] = {
    minLevel = 1,
    run = function(args)
        local tName = args[1]
        if not tName then sysMsg("Uso: /unmute <apodo>") return end
        local t = findPlayer(tName)
        if not t then sysMsg("Jugador '" .. tName .. "' no encontrado.") return end
        mutes[tostring(t.UserId)] = nil; saveMutes()
        sysMsg(t.DisplayName .. " desmuteado por " .. lplr.DisplayName .. ".")
        if shared.nexoLocalChatEvent then
            shared.nexoLocalChatEvent:Fire("__CMD__","__CMD__",0,"UNMUTE:"..t.UserId)
        end
    end,
}

COMMANDS["ban"] = {
    minLevel = 2,
    run = function(args)
        local uidStr, durStr = args[1], args[2]
        local uid = tonumber(uidStr)
        if not uid then sysMsg("Uso: /ban <userId> <tiempo|perm>") return end
        if getRankLevel(uid) >= getRankLevel(lplr.UserId) then
            sysMsg("No puedes banear a alguien de igual o mayor rango.") return
        end
        local secs   = parseDuration(durStr or "perm")
        local expiry = secs and (os.time() + secs) or nil
        bans[tostring(uid)] = { expiry = expiry }
        saveBans()
        local p     = Players:GetPlayerByUserId(uid)
        local label = p and p.DisplayName or ("UserId " .. uid)
        sysMsg(label .. " baneado (" .. (expiry and durStr or "permanente") .. ") por " .. lplr.DisplayName .. ".")
        if shared.nexoLocalChatEvent then
            shared.nexoLocalChatEvent:Fire("__CMD__","__CMD__",0,"BAN:"..uid..":"..tostring(expiry or "nil"))
        end
    end,
}

COMMANDS["unban"] = {
    minLevel = 2,
    run = function(args)
        local tName = args[1]
        if not tName then sysMsg("Uso: /unban <apodo>") return end
        local t = findPlayer(tName)
        if not t then
            sysMsg("No estÃ¡ en el servidor. Usa /unban_id <userId> para offline.") return
        end
        bans[tostring(t.UserId)] = nil; saveBans()
        sysMsg(t.DisplayName .. " desbaneado por " .. lplr.DisplayName .. ".")
        if shared.nexoLocalChatEvent then
            shared.nexoLocalChatEvent:Fire("__CMD__","__CMD__",0,"UNBAN:"..t.UserId)
        end
    end,
}

COMMANDS["unban_id"] = {
    minLevel = 2,
    run = function(args)
        local uid = args[1]
        if not uid then sysMsg("Uso: /unban_id <userId>") return end
        bans[uid] = nil; saveBans()
        sysMsg("UserId " .. uid .. " desbaneado.")
    end,
}

COMMANDS["setrank"] = {
    minLevel = 2,
    run = function(args)
        local tName, rankStr = args[1], args[2] and args[2]:lower()
        if not tName or not rankStr then
            sysMsg("Uso: /setrank <apodo> <owner|admin|mod|none>") return
        end
        local t = findPlayer(tName)
        if not t then sysMsg("Jugador '" .. tName .. "' no encontrado.") return end
        local myLv = getRankLevel(lplr.UserId)
        if rankStr == "none" then
            if getRankLevel(t.UserId) >= myLv then
                sysMsg("No puedes quitar el rango a alguien de igual o mayor nivel.") return
            end
            ranks[tostring(t.UserId)] = nil; saveRanks()
            sysMsg(t.DisplayName .. " ya no tiene rango.")
        elseif RANK_INFO[rankStr] then
            if RANK_INFO[rankStr].level >= myLv then
                sysMsg("No puedes dar un rango igual o mayor al tuyo.") return
            end
            ranks[tostring(t.UserId)] = rankStr; saveRanks()
            sysMsg(t.DisplayName .. " ahora es " .. RANK_INFO[rankStr].label .. ".")
        else
            sysMsg("Rango invÃ¡lido: owner | admin | mod | none")
        end
    end,
}

local function handleCommand(text)
    if text:sub(1,1) ~= "/" then return false end
    local parts = {}
    for w in text:gmatch("%S+") do table.insert(parts, w) end
    local cmdName = parts[1]:sub(2):lower()
    local args = {}
    for i = 2, #parts do table.insert(args, parts[i]) end
    local cmd = COMMANDS[cmdName]
    if not cmd then sysMsg("Comando desconocido: /"..cmdName.."  (/ayuda)") return true end
    if getRankLevel(lplr.UserId) < cmd.minLevel then
        sysMsg("Sin permisos para usar /"..cmdName..".") return true
    end
    cmd.run(args)
    return true
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  ENVIAR MENSAJE
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local function sendMessage()
    closeMentionPopup()
    local text = ChatInput.Text
    if text == "" then return end
    ChatInput.Text = ""

    if handleCommand(text) then return end
    if #text > 200 then sysMsg("Mensaje muy largo (mÃ¡x 200 caracteres).") return end

    if isBanned(lplr.UserId)  then sysMsg("EstÃ¡s baneado del chat.")  return end
    if isMuted(lplr.UserId)   then sysMsg("[Sistema] Error: este usuario no puede escribir porque estÃ¡ muteado.") return end

    local myRank = getRank(lplr.UserId)
    -- Se envÃ­a DisplayName para mostrar, UserId para identidad
    addMessage(lplr.DisplayName, lplr.UserId, text, true, myRank)

    if shared.nexoLocalChatEvent then
        shared.nexoLocalChatEvent:Fire(
            tostring(lplr.UserId),   -- clave Ãºnica (no el nombre)
            lplr.DisplayName,        -- apodo visual
            lplr.UserId,
            text,
            myRank or ""
        )
    end
end

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  EVENTO COMPARTIDO
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
local LocalEvent = Instance.new("BindableEvent")
shared.nexoLocalChatEvent = LocalEvent

LocalEvent.Event:Connect(function(senderKey, displayName, userId, text, rankKey)
    -- Paquetes de comando interno
    if senderKey == "__CMD__" then
        if text:sub(1,5) == "MUTE:" then
            local uid, exp = text:match("MUTE:(%d+):(.*)")
            mutes[uid] = { expiry = (exp ~= "nil") and tonumber(exp) or nil }; saveMutes()
            if uid == tostring(lplr.UserId) then applyMuteState() end
        elseif text:sub(1,7) == "UNMUTE:" then
            local uid = text:match("UNMUTE:(%d+)")
            mutes[uid] = nil; saveMutes()
            if uid == tostring(lplr.UserId) then applyMuteState() end
        elseif text:sub(1,4) == "BAN:" then
            local uid, exp = text:match("BAN:(%d+):(.*)")
            bans[uid] = { expiry = (exp ~= "nil") and tonumber(exp) or nil }; saveBans()
        elseif text:sub(1,6) == "UNBAN:" then
            bans[text:match("UNBAN:(%d+)")] = nil; saveBans()
        elseif text:sub(1,6) == "CLEAR:" then
            for _, c in ipairs(ScrollFrame:GetChildren()) do
                if c:IsA("Frame") then c:Destroy() end
            end
            messageCount = 0
            sysMsg("Chat limpiado por " .. text:match("CLEAR:(.+)") .. ".")
        end
        return
    end

    -- Ignorar mensajes propios
    if senderKey == tostring(lplr.UserId) then return end

    if isBanned(userId) or isMuted(userId) then return end

    -- Quien manda un mensaje por este chat queda registrado
    -- como "usuario del script" para el autocompletado de @menciones
    scriptUsers[senderKey] = true

    local rk = (rankKey ~= "" and rankKey ~= nil) and rankKey or nil
    addMessage(displayName, userId, text, false, rk)
end)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  EVENTOS DE JUGADORES
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
Players.PlayerAdded:Connect(function()
    TitleLabel.Text = "Chat Local  â€¢  " .. #Players:GetPlayers() .. " jugadores"
end)
Players.PlayerRemoving:Connect(function()
    task.defer(function()
        TitleLabel.Text = "Chat Local  â€¢  " .. #Players:GetPlayers() .. " jugadores"
    end)
end)
TitleLabel.Text = "Chat Local  â€¢  " .. #Players:GetPlayers() .. " jugadores"

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  BOTONES E INPUT
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
SendBtn.MouseButton1Click:Connect(sendMessage)

ChatInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then sendMessage() end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == CONFIG.ChatKey and not gameProcessed then
        if not ChatInput:IsFocused() then ChatInput:CaptureFocus() end
    end
    -- Escape cierra el popup de menciones
    if input.KeyCode == Enum.KeyCode.Escape then
        closeMentionPopup()
    end
end)

-- Minimizar / Maximizar
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart),
            {Size = UDim2.new(0,340,0,32)}):Play()
        ScrollFrame.Visible = false; InputFrame.Visible = false
        TagLabel.Visible = false; MentionPopup.Visible = false
        MinBtn.Text = "â–¡"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart),
            {Size = originalSize}):Play()
        ScrollFrame.Visible = true; InputFrame.Visible = true
        TagLabel.Visible = true; MinBtn.Text = "â€”"
    end
    persistConfig()
end)

if cfg.Minimized then
    MainFrame.Size = UDim2.new(0,340,0,32)
    ScrollFrame.Visible = false; InputFrame.Visible = false
    TagLabel.Visible = false; MinBtn.Text = "â–¡"
end

-- Arrastrar ventana
local dragging, dragStart, startPos = false, nil, nil

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)

TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false; persistConfig()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

game:BindToClose(persistConfig)

-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--  INICIO
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
task.delay(0.5, function()
    local myRank = getRank(lplr.UserId)
    local rankMsg = myRank and ("  Tu rango: " .. RANK_INFO[myRank].label) or ""
    sysMsg("Â¡Chat local iniciado! Solo jugadores de este servidor pueden leerte." .. rankMsg)
    sysMsg("Escribe @ para mencionar jugadores por apodo  â€¢  /ayuda para comandos.")
end)

print("[NexoChat] Chat + SaveManager + Rangos + @Menciones cargado.")
