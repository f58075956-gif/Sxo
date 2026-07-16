--[[
	VulnLoggerGui.lua
	------------------------------------------------------------
	GUI para Roblox que muestra el reporte generado por VulnLogger.scan().
	Pensado para correr en un LocalScript (StarterPlayerScripts o
	StarterGui) o ser llamado desde ahÃ­.

	USO:
		local VulnLogger    = require(game.ServerScriptService.VulnLogger) -- o donde lo tengas
		local VulnLoggerGui = require(path.to.VulnLoggerGui)

		local reporte = VulnLogger.scan(codigoFuente, "TiendaServer")
		VulnLoggerGui.show(reporte)
	------------------------------------------------------------
]]

local Players = game:GetService("Players")

local VulnLoggerGui = {}

local SEVERITY_COLOR = {
	["CRÃTICA"] = Color3.fromRGB(255, 70, 70),
	["ALTA"]    = Color3.fromRGB(255, 150, 60),
	["MEDIA"]   = Color3.fromRGB(240, 210, 60),
	["BAJA"]    = Color3.fromRGB(160, 160, 160),
}

-- Elimina una GUI anterior si ya existe, para no duplicar
local function clearExisting(playerGui)
	local existing = playerGui:FindFirstChild("VulnLoggerGui")
	if existing then
		existing:Destroy()
	end
end

--[[
	report: la tabla que devuelve VulnLogger.scan(...)
		{ scriptName, findings = { {line, code, name, severity, explain}, ... }, texto }
]]
function VulnLoggerGui.show(report)
	local player = Players.LocalPlayer
	if not player then
		warn("VulnLoggerGui.show debe correr en un LocalScript (LocalPlayer no encontrado).")
		return
	end
	local playerGui = player:WaitForChild("PlayerGui")
	clearExisting(playerGui)

	-- ScreenGui raÃ­z
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "VulnLoggerGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = playerGui

	-- Ventana principal
	local main = Instance.new("Frame")
	main.Name = "MainWindow"
	main.Size = UDim2.new(0, 560, 0, 420)
	main.Position = UDim2.new(0.5, -280, 0.5, -210)
	main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	main.BorderSizePixel = 0
	main.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = main

	-- Barra superior
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 44)
	titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	titleBar.BorderSizePixel = 0
	titleBar.Parent = main

	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 10)
	titleCorner.Parent = titleBar

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.BackgroundTransparency = 1
	titleLabel.Size = UDim2.new(1, -90, 1, 0)
	titleLabel.Position = UDim2.new(0, 16, 0, 0)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 16
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Text = ("Reporte de vulnerabilidades â€” %s (%d hallazgos)")
		:format(report.scriptName or "Script", #report.findings)
	titleLabel.Parent = titleBar

	-- BotÃ³n cerrar
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -40, 0, 7)
	closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 66)
	closeButton.Text = "X"
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 14
	closeButton.Parent = titleBar

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 6)
	closeCorner.Parent = closeButton

	closeButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	-- Ãrea con scroll para los hallazgos
	local scroll = Instance.new("ScrollingFrame")
	scroll.Name = "Findings"
	scroll.Size = UDim2.new(1, -20, 1, -60)
	scroll.Position = UDim2.new(0, 10, 0, 52)
	scroll.BackgroundTransparency = 1
	scroll.BorderSizePixel = 0
	scroll.ScrollBarThickness = 6
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.Parent = main

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = scroll

	if #report.findings == 0 then
		local okLabel = Instance.new("TextLabel")
		okLabel.BackgroundTransparency = 1
		okLabel.Size = UDim2.new(1, 0, 0, 60)
		okLabel.Font = Enum.Font.Gotham
		okLabel.TextSize = 14
		okLabel.TextColor3 = Color3.fromRGB(140, 220, 140)
		okLabel.TextWrapped = true
		okLabel.TextXAlignment = Enum.TextXAlignment.Left
		okLabel.Text = "No se detectaron patrones de riesgo conocidos. RevisÃ¡ igual la lÃ³gica de negocio a mano."
		okLabel.Parent = scroll
	else
		for i, f in ipairs(report.findings) do
			local item = Instance.new("Frame")
			item.Name = "Finding" .. i
			item.LayoutOrder = i
			item.AutomaticSize = Enum.AutomaticSize.Y
			item.Size = UDim2.new(1, -6, 0, 0)
			item.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
			item.BorderSizePixel = 0
			item.Parent = scroll

			local itemCorner = Instance.new("UICorner")
			itemCorner.CornerRadius = UDim.new(0, 8)
			itemCorner.Parent = item

			local pad = Instance.new("UIPadding")
			pad.PaddingTop = UDim.new(0, 8)
			pad.PaddingBottom = UDim.new(0, 8)
			pad.PaddingLeft = UDim.new(0, 10)
			pad.PaddingRight = UDim.new(0, 10)
			pad.Parent = item

			local vlayout = Instance.new("UIListLayout")
			vlayout.Padding = UDim.new(0, 2)
			vlayout.SortOrder = Enum.SortOrder.LayoutOrder
			vlayout.Parent = item

			local header = Instance.new("TextLabel")
			header.BackgroundTransparency = 1
			header.Size = UDim2.new(1, 0, 0, 18)
			header.Font = Enum.Font.GothamBold
			header.TextSize = 13
			header.TextXAlignment = Enum.TextXAlignment.Left
			header.TextColor3 = SEVERITY_COLOR[f.severity] or Color3.fromRGB(255, 255, 255)
			header.Text = ("[%s] lÃ­nea %d â€” %s"):format(f.severity, f.line, f.name)
			header.LayoutOrder = 1
			header.Parent = item

			local codeLabel = Instance.new("TextLabel")
			codeLabel.BackgroundTransparency = 1
			codeLabel.Size = UDim2.new(1, 0, 0, 16)
			codeLabel.Font = Enum.Font.Code
			codeLabel.TextSize = 12
			codeLabel.TextXAlignment = Enum.TextXAlignment.Left
			codeLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
			codeLabel.TextTruncate = Enum.TextTruncate.AtEnd
			codeLabel.Text = f.code
			codeLabel.LayoutOrder = 2
			codeLabel.Parent = item

			local explainLabel = Instance.new("TextLabel")
			explainLabel.BackgroundTransparency = 1
			explainLabel.Size = UDim2.new(1, 0, 0, 0)
			explainLabel.AutomaticSize = Enum.AutomaticSize.Y
			explainLabel.Font = Enum.Font.Gotham
			explainLabel.TextSize = 12
			explainLabel.TextWrapped = true
			explainLabel.TextXAlignment = Enum.TextXAlignment.Left
			explainLabel.TextColor3 = Color3.fromRGB(210, 210, 215)
			explainLabel.Text = f.explain
			explainLabel.LayoutOrder = 3
			explainLabel.Parent = item
		end
	end

	return screenGui
end

return VulnLoggerGui
