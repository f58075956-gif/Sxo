local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local muscleEvent = player:WaitForChild("muscleEvent")
local leaderstats = player:WaitForChild("leaderstats")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")

local function getCharacter()
return player.Character or player.CharacterAdded:Wait()
end

local title = "🔥 Packs privated | Bienvenido - " .. player.DisplayName

local library = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/f58075956-gif/Sxo/refs/heads/main/W%20UI.txt",
true
))()

local window = library:AddWindow(title, {
main_color = Color3.fromRGB(0, 0, 0),
min_size = Vector2.new(360, 360),
can_resize = true,
})

local FarmingTab = window:AddTab("Farm")
local Folderpapu = FarmingTab:AddFolder("con packs")

local SwiftSamuraiAmount = 8
local TribalOverlordAmount = 8

Folderpapu:AddTextBox("Swift Samurai Amount", function(value)
local num = tonumber(value)

if num then
SwiftSamuraiAmount = math.clamp(math.floor(num), 1, 8)
end

end, {
placeholder = "8"
})

Folderpapu:AddTextBox("Tribal Overlord Amount", function(value)
local num = tonumber(value)

if num then
TribalOverlordAmount = math.clamp(math.floor(num), 1, 8)
end

end, {
placeholder = "8"
})

Folderpapu:AddSwitch("FAST REBIRTH", function(state)
omegaFarmLegends = state

if not state then
return
end

task.spawn(function()

local globalFunctions = require(    
	ReplicatedStorage:WaitForChild("globalFunctions")    
)    

local leaderstats = player:WaitForChild("leaderstats")    
local Strength = leaderstats:WaitForChild("Strength")    
local Rebirths = leaderstats:WaitForChild("Rebirths")    

local rebirthRemote = ReplicatedStorage.rEvents.rebirthRemote    
local equipPetEvent = ReplicatedStorage.rEvents.equipPetEvent    

local function unequipAllPets()    
	local petsFolder = player:WaitForChild("petsFolder")    

	for _, folder in pairs(petsFolder:GetChildren()) do    
		if folder:IsA("Folder") then    
			for _, pet in pairs(folder:GetChildren()) do    
				equipPetEvent:FireServer("unequipPet", pet)    
			end    
		end    
	end    
end    

local function equipPet(petName, amount)    
	unequipAllPets()    
	task.wait(0.05)    

	local equipped = 0    

	for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do    
		if pet.Name == petName then    
			equipPetEvent:FireServer("equipPet", pet)    

			equipped += 1    

			if equipped >= amount then    
				break    
			end    
		end    
	end    
end    

while omegaFarmLegends do    

	local neededStrength =    
		globalFunctions.calculateRequiredRebirthStrength(    
			Rebirths.Value,    
			player    
		)    

	equipPet("Swift Samurai", SwiftSamuraiAmount)    

	while Strength.Value < neededStrength and omegaFarmLegends do    
		for i = 1, 10 do    
			muscleEvent:FireServer("rep")    
		end    

		task.wait()    
	end    

	if omegaFarmLegends then    
		equipPet("Tribal Overlord", TribalOverlordAmount)    

		local oldRebirths = Rebirths.Value    

		repeat    
			rebirthRemote:InvokeServer("rebirthRequest")    
			task.wait()    
		until Rebirths.Value > oldRebirths or not omegaFarmLegends    
	end    

	task.wait(1)    
end
end)
end)

local playerWhitelist = {}
local targetPlayerNames = {}
local autoGoodKarma = false
local autoBadKarma = false
local autoKill = false
local killTarget = false
local spying = false
local autoEquipPunch = false
local autoPunchNoAnim = false
local targetDropdownItems = {}
local availableTargets = {}
local Killer = window:AddTab("killer")
Killer:AddSwitch("equipar y desequipar", function(bool)
    if bool then
        local player = game.Players.LocalPlayer
        local petsFolder = player.petsFolder
        local remoteEvent = game:GetService("ReplicatedStorage").rEvents.equipPetEvent

        -- 1. Desequipar todas las mascotas equipadas actualmente
        for _, folder in pairs(petsFolder:GetChildren()) do
            if folder:IsA("Folder") then
                for _, pet in pairs(folder:GetChildren()) do
                    remoteEvent:FireServer("unequipPet", pet)
                end
            end
        end

        task.wait(0.3)

        -- 2. Buscar las mascotas que quiero equipar (por nombre exacto)
        local petNamesToEquip = {"Mighty Monster", "Wild Wizard"}
        local petsToEquip = {}

        for _, pet in pairs(petsFolder.Unique:GetChildren()) do
            for _, name in pairs(petNamesToEquip) do
                if pet.Name == name then
                    table.insert(petsToEquip, pet)
                end
            end
        end

        -- 3. Equipar hasta 8 en total
        local maxPets = 8
        local equippedCount = math.min(#petsToEquip, maxPets)

        for i = 1, equippedCount do
            remoteEvent:FireServer("equipPet", petsToEquip[i])
            task.wait(0.15)
        end
    end
end)


local titleLabel = Killer:AddLabel("Equipar pet de dura o daño")
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.Merriweather 
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local dropdown = Killer:AddDropdown("Select Pet", function(text)
    local petsFolder = game.Players.LocalPlayer.petsFolder
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.2)

    local petName = text
    local petsToEquip = {}

    for _, pet in pairs(game.Players.LocalPlayer.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            table.insert(petsToEquip, pet)
        end
    end

    local maxPets = 8
    local equippedCount = math.min(#petsToEquip, maxPets)

    for i = 1, equippedCount do
        game:GetService("ReplicatedStorage").rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
        task.wait(0.1)
    end
end)

local Wild_Wizard = dropdown:Add("Wild Wizard")
local Powerful_Monster = dropdown:Add("Mighty Monster")
local Folderkarma = killer:AddFolder("crystals")

Folderkarma:AddSwitch("Auto Good Karma", function(bool)
    autoGoodKarma = bool
    task.spawn(function()
        while autoGoodKarma do
            local playerChar = LocalPlayer.Character
            local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
            local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")
            if playerChar and rightHand and leftHand then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= LocalPlayer then
                        local evilKarma = target:FindFirstChild("evilKarma")
                        local goodKarma = target:FindFirstChild("goodKarma")
                        if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and evilKarma.Value > goodKarma.Value then
                            local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                            if rootPart then
                                firetouchinterest(rightHand, rootPart, 1)
                                firetouchinterest(leftHand, rootPart, 1)
                                firetouchinterest(rightHand, rootPart, 0)
                                firetouchinterest(leftHand, rootPart, 0)
                            end
                        end
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)

Folderkarma:AddSwitch("Auto Bad Karma", function(bool)
    autoBadKarma = bool
    task.spawn(function()
        while autoBadKarma do
            local playerChar = LocalPlayer.Character
            local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
            local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")
            if playerChar and rightHand and leftHand then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= LocalPlayer then
                        local evilKarma = target:FindFirstChild("evilKarma")
                        local goodKarma = target:FindFirstChild("goodKarma")
                        if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and goodKarma.Value > evilKarma.Value then
                            local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                            if rootPart then
                                firetouchinterest(rightHand, rootPart, 1)
                                firetouchinterest(leftHand, rootPart, 1)
                                firetouchinterest(rightHand, rootPart, 0)
                                firetouchinterest(leftHand, rootPart, 0)
                            end
                        end
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)
local FolderWhitelist = killer:AddFolder("crystals")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local friendWhitelistActive = false

FolderWhitelist:AddSwitch("Auto Whitelist Friends", function(state)
    friendWhitelistActive = state

    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
                playerWhitelist[player.Name] = true
            end
        end

        Players.PlayerAdded:Connect(function(player)
            if friendWhitelistActive and player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
                playerWhitelist[player.Name] = true
            end
        end)
    else
        for name in pairs(playerWhitelist) do
            local friend = Players:FindFirstChild(name)
            if friend and LocalPlayer:IsFriendsWith(friend.UserId) then
                playerWhitelist[name] = nil
            end
        end
    end
end)

FolderWhitelist:AddTextBox("Whitelist", function(text)
    local target = Players:FindFirstChild(text)
    if target then
        playerWhitelist[target.Name] = true
    end
end)

FolderWhitelist:AddTextBox("UnWhitelist", function(text)
    local target = Players:FindFirstChild(text)
    if target then
        playerWhitelist[target.Name] = nil
    end
end)

FolderWhitelist:AddSwitch("Auto Kill", function(bool)
    autoKill = bool

    task.spawn(function()
        while autoKill do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local rightHand = character:FindFirstChild("RightHand")
            local leftHand = character:FindFirstChild("LeftHand")

            local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
            if punch and not character:FindFirstChild("Punch") then
                punch.Parent = character
            end

            if rightHand and leftHand then
                for _, target in ipairs(Players:GetPlayers()) do
                    if target ~= LocalPlayer and not playerWhitelist[target.Name] then
                        local targetChar = target.Character
                        local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            pcall(function()
                                firetouchinterest(rightHand, rootPart, 1)
                                firetouchinterest(leftHand, rootPart, 1)
                                firetouchinterest(rightHand, rootPart, 0)
                                firetouchinterest(leftHand, rootPart, 0)
                            end)
                        end
                    end
                end
            end

            task.wait(0.05)
        end
    end)
end)

local targetDropdown = FolderWhitelist:AddDropdown("Select Target", function(name)
    if name and not table.find(targetPlayerNames, name) then
        table.insert(targetPlayerNames, name)
    end
end)

FolderWhitelist:AddTextBox("Remove Target", function(name)
    for i, v in ipairs(targetPlayerNames) do
        if v == name then
            table.remove(targetPlayerNames, i)
            break
        end
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        targetDropdown:Add(player.Name)
        targetDropdownItems[player.Name] = true
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        targetDropdown:Add(player.Name)
        targetDropdownItems[player.Name] = true
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if targetDropdownItems[player.Name] then
        targetDropdownItems[player.Name] = nil
        targetDropdown:Clear()
        for name in pairs(targetDropdownItems) do
            targetDropdown:Add(name)
        end
    end

    for i = #targetPlayerNames, 1, -1 do
        if targetPlayerNames[i] == player.Name then
            table.remove(targetPlayerNames, i)
        end
    end
end)

FolderWhitelist:AddSwitch("Start Kill Target", function(state)
    killTarget = state

    task.spawn(function()
        while killTarget do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

            local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
            if punch and not character:FindFirstChild("Punch") then
                punch.Parent = character
            end

            local rightHand = character:WaitForChild("RightHand", 5)
            local leftHand = character:WaitForChild("LeftHand", 5)

            if rightHand and leftHand then
                for _, name in ipairs(targetPlayerNames) do
                    local target = Players:FindFirstChild(name)
                    if target and target ~= LocalPlayer then
                        local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            pcall(function()
                                firetouchinterest(rightHand, rootPart, 1)
                                firetouchinterest(leftHand, rootPart, 1)
                                firetouchinterest(rightHand, rootPart, 0)
                                firetouchinterest(leftHand, rootPart, 0)
                            end)
                        end
                    end
                end
            end

            task.wait(0.05)
        end
    end)
end)

local spyTargetDropdown = FolderWhitelist:AddDropdown("Select View Target", function(name)
    targetPlayerName = name
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        spyTargetDropdown:Add(player.Name)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        spyTargetDropdown:Add(player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if player ~= LocalPlayer then
        spyTargetDropdown:Clear()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                spyTargetDropdown:Add(plr.Name)
            end
        end
    end
end)

FolderWhitelist:AddSwitch("View Player", function(bool)
    spying = bool
    if not spying then
        local cam = workspace.CurrentCamera
        cam.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer
        return
    end
    task.spawn(function()
        while spying do
            local target = Players:FindFirstChild(targetPlayerName)
            if target and target ~= LocalPlayer then
                local humanoid = target.Character and target.Character:FindFirstChild("Humanoid")
                if humanoid then
                    workspace.CurrentCamera.CameraSubject = humanoid
                end
            end
            task.wait(0.1)
        end
    end)
end)
local Folderpunch = killer:AddFolder("crystals")
local button = Folderpunch:AddButton("Remove Punch Anim", function()
    local blockedAnimations = {
        ["rbxassetid://3638729053"] = true,
        ["rbxassetid://3638767427"] = true,
    }

    local function setupAnimationBlocking()
        local char = game.Players.LocalPlayer.Character
        if not char or not char:FindFirstChild("Humanoid") then return end

        local humanoid = char:FindFirstChild("Humanoid")

        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation then
                local animId = track.Animation.AnimationId
                local animName = track.Name:lower()

                if blockedAnimations[animId] or
                    animName:match("punch") or
                    animName:match("attack") or
                    animName:match("right") then
                    track:Stop()
                end
            end
        end

        if not _G.AnimBlockConnection then
            local connection = humanoid.AnimationPlayed:Connect(function(track)
                if track.Animation then
                    local animId = track.Animation.AnimationId
                    local animName = track.Name:lower()

                    if blockedAnimations[animId] or
                        animName:match("punch") or
                        animName:match("attack") or
                        animName:match("right") then
                        track:Stop()
                    end
                end
            end)

            _G.AnimBlockConnection = connection
        end
    end

    setupAnimationBlocking()

    local function overrideToolActivation()
        local function processTool(tool)
            if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
                if not tool:GetAttribute("ActivatedOverride") then
                    tool:SetAttribute("ActivatedOverride", true)

                    local connection = tool.Activated:Connect(function()
                        task.wait(0.05)

                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("Humanoid") then
                            for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                                if track.Animation then
                                    local animId = track.Animation.AnimationId
                                    local animName = track.Name:lower()

                                    if blockedAnimations[animId] or
                                        animName:match("punch") or
                                        animName:match("attack") or
                                        animName:match("right") then
                                        track:Stop()
                                    end
                                end
                            end
                        end
                    end)

                    if not _G.ToolConnections then
                        _G.ToolConnections = {}
                    end
                    _G.ToolConnections[tool] = connection
                end
            end
        end

        for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            processTool(tool)
        end

        local char = game.Players.LocalPlayer.Character
        if char then
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    processTool(tool)
                end
            end
        end

        if not _G.BackpackAddedConnection then
            _G.BackpackAddedConnection = game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    processTool(child)
                end
            end)
        end

        if not _G.CharacterToolAddedConnection and char then
            _G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    processTool(child)
                end
            end)
        end
    end

    overrideToolActivation()

    if not _G.AnimMonitorConnection then
        _G.AnimMonitorConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() % 0.5 < 0.01 then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                        if track.Animation then
                            local animId = track.Animation.AnimationId
                            local animName = track.Name:lower()

                            if blockedAnimations[animId] or
                                animName:match("punch") or
                                animName:match("attack") or
                                animName:match("right") then
                                track:Stop()
                            end
                        end
                    end
                end
            end
        end)
    end

    if not _G.CharacterAddedConnection then
        _G.CharacterAddedConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
            task.wait(1)
            setupAnimationBlocking()
            overrideToolActivation()

            if _G.CharacterToolAddedConnection then
                _G.CharacterToolAddedConnection:Disconnect()
            end

            _G.CharacterToolAddedConnection = newChar.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then
                    task.wait(0.1)
                    processTool(child)
                end
            end)
        end)
    end
end)

function RecoveryPunch()
    if _G.AnimBlockConnection then
        _G.AnimBlockConnection:Disconnect()
        _G.AnimBlockConnection = nil
    end
    if _G.AnimMonitorConnection then
        _G.AnimMonitorConnection:Disconnect()
        _G.AnimMonitorConnection = nil
    end
    if _G.ToolConnections then
        for _, conn in pairs(_G.ToolConnections) do
            if conn then conn:Disconnect() end
        end
        _G.ToolConnections = nil
    end
    if _G.BackpackAddedConnection then
        _G.BackpackAddedConnection:Disconnect()
        _G.BackpackAddedConnection = nil
    end
    if _G.CharacterToolAddedConnection then
        _G.CharacterToolAddedConnection:Disconnect()
        _G.CharacterToolAddedConnection = nil
    end
    if _G.CharacterAddedConnection then
        _G.CharacterAddedConnection:Disconnect()
        _G.CharacterAddedConnection = nil
    end
end

Folderpunch:AddButton("Recover Punch Anim", function()
    RecoveryPunch()
end)

Folderpunch:AddSwitch("Auto Equip Punch", function(state)
	autoEquipPunch = state
	task.spawn(function()
		while autoEquipPunch do
			local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
			if punch then
				punch.Parent = LocalPlayer.Character
			end
			task.wait(0.1)
		end
	end)
end)

Folderpunch:AddSwitch("Auto golpear [sin animación]", function(state)
	autoPunchNoAnim = state
	task.spawn(function()
		while autoPunchNoAnim do
			local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
			if punch then
				if punch.Parent ~= LocalPlayer.Character then
					punch.Parent = LocalPlayer.Character
				end
				LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
				LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
			else
				autoPunchNoAnim = false
			end
			task.wait(0.01)
		end
	end)
end)

Folderpunch:AddSwitch("Auto Punch", function(state)
	_G.fastHitActive = state
	if state then
		task.spawn(function()
			while _G.fastHitActive do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch then
					punch.Parent = LocalPlayer.Character
					if punch:FindFirstChild("attackTime") then
						punch.attackTime.Value = 0
					end
				end
				task.wait(0.1)
			end
		end)
		task.spawn(function()
			while _G.fastHitActive do
				local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
				if punch then
					punch:Activate()
				end
				task.wait(0.1)
			end
		end)
	else
		local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
		if punch then
			punch.Parent = LocalPlayer.Backpack
		end
	end
end)

Folderpunch:AddSwitch("golpe rápido", function(state)
	_G.autoPunchActive = state
	if state then
		task.spawn(function()
			while _G.autoPunchActive do
				local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
				if punch then
					punch.Parent = LocalPlayer.Character
					if punch:FindFirstChild("attackTime") then
						punch.attackTime.Value = 0
					end
				end
				task.wait()
			end
		end)
		task.spawn(function()
			while _G.autoPunchActive do
				local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
				if punch then
					punch:Activate()
				end
				task.wait()
			end
		end)
	else
		local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
		if punch then
			punch.Parent = LocalPlayer.Backpack
		end
	end
end)
local Folderop = killer:AddFolder("crystals")


local godModeToggle = false
Folderop:AddSwitch("modo dios (esperar peleas)", function(State)
    godModeToggle = State
    if State then
        task.spawn(function()
            while godModeToggle do
                game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                task.wait()
            end
        end)
    end
end)
-- 📌 Teleport / Follow System (versión auto-follow desde Dropdown)

-- 📌 Auto Follow (TP detrás del jugador en vez de caminar)
local following = false
local followTarget = nil

-- Función auxiliar: TP detrás del jugador
function followPlayer(targetPlayer)
    local myChar = LocalPlayer.Character
    local targetChar = targetPlayer.Character

    if not (myChar and targetChar) then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")

    if myHRP and targetHRP then
        -- 📌 Calcular posición detrás del jugador (3 studs atrás)
        local followPos = targetHRP.Position - (targetHRP.CFrame.LookVector * 3)
        -- 📌 Teletransportar siempre recto
        myHRP.CFrame = CFrame.new(followPos, targetHRP.Position)
    end
end

-- Dropdown dinámico de jugadores
local followDropdown = Folderop:AddDropdown("Seguir Jugador (TP)", function(selected)
    if selected and selected ~= "" then
        local target = Players:FindFirstChild(selected)
        if target then
            followTarget = target.Name
            following = true
            print("Started following:", target.Name)

            -- TP inmediato al seleccionarlo
            followPlayer(target)
        end
    end
end)

-- Inicializar lista de jugadores
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        followDropdown:Add(player.Name)
    end
end

-- Mantener lista actualizada
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        followDropdown:Add(player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    followDropdown:Clear()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            followDropdown:Add(plr.Name)
        end
    end
    if followTarget == player.Name then
        followTarget = nil
        following = false
    end
end)

-- Botón para dejar de seguir
Folderop:AddButton("Dejar de Seguir", function()
    following = false
    followTarget = nil
    print("Stopped following")
end)

-- Loop de seguimiento automático
task.spawn(function()
    while true do
        task.wait(0.2) -- cada 0.2s para actualizar TP
        if following and followTarget then
            local target = Players:FindFirstChild(followTarget)
            if target then
                followPlayer(target)
            else
                following = false
                followTarget = nil
            end
        end
    end
end)

local godDamageActive = false

Folderop:AddSwitch("Daño con Godmode", function(state)
    godDamageActive = state
    if state then
        task.spawn(function()
            while godDamageActive do
                local player = game.Players.LocalPlayer
                local groundSlam = player.Backpack:FindFirstChild("Ground Slam") or (player.Character and player.Character:FindFirstChild("Ground Slam"))

                if groundSlam then
                    -- Equipar
                    if groundSlam.Parent == player.Backpack then
                        groundSlam.Parent = player.Character
                    end

                    -- Quitar delay
                    if groundSlam:FindFirstChild("attackTime") then
                        groundSlam.attackTime.Value = 0
                    end

                    -- Lanzar evento
                    player.muscleEvent:FireServer("slam")

                    -- Activar herramienta
                    groundSlam:Activate()
                end

                task.wait(0.1) -- delay pequeño
            end
        end)
    end
end)

Folderop:AddButton("Tamaño NaN", function()
    local args = {"changeSize", 0/0}
    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("changeSpeedSizeRemote"):InvokeServer(unpack(args))
end)
-- 📜 Lista de RAWs a ejecutar
local urls = {
    "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack",
    "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack2",
    "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack3",
    "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack4",
    "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack5",
    "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack6"
}

-- ⚡ Botón que ejecuta todos los scripts remotos
Folderop:AddButton("Pegar Muerto", function()
    for _, url in ipairs(urls) do
        spawn(function()
            local success, response = pcall(function()
                return game:HttpGet(url)
            end)
            if success and response then
                local loadSuccess, err = pcall(function()
                    loadstring(response)()
                end)
                if not loadSuccess then
                    warn("[Pegar Muerto] Error ejecutando raw:", url, err)
                end
            else
                warn("[Pegar Muerto] No se pudo cargar:", url)
            end
        end)
    end
end)


-- Sistema de Auto Area Travel
local autoAreaTravelEnabled = false

Folderop:AddSwitch("Auto GODMODE Join Tiny island", function(state)
    autoAreaTravelEnabled = state
    
    if state then
        warn("ðŸ”„ Auto Area Travel ATIVADO - Tentando viajar para Ã¡rea...")
        task.spawn(function()
            local success, result = pcall(function()
                local Event = game:GetService("ReplicatedStorage").rEvents.areaTravelRemote
                return Event:InvokeServer("travelToArea", workspace.areaCircles.areaCircle)
            end)
            
            if success then
                warn("âœ… Viagem de Ã¡rea executada com sucesso!")
                StarterGui:SetCore("SendNotification", {
                    Title = "Area Travel",
                    Text = "Viagem realizada com sucesso!",
                    Duration = 5
                })
            else
                warn("âŒ Erro ao viajar para Ã¡rea:", result)
                StarterGui:SetCore("SendNotification", {
                    Title = "Area Travel",
                    Text = "Erro: " .. tostring(result),
                    Duration = 5
                })
            end
        end)
    else
        warn("â›” Auto Area Travel DESATIVADO")
    end
end)

task.spawn(function()
    while true do
        if autoAreaTravelEnabled then
            task.wait(10)
            
            local success, result = pcall(function()
                local Event = game:GetService("ReplicatedStorage").rEvents.areaTravelRemote
                return Event:InvokeServer("travelToArea", workspace.areaCircles.areaCircle)
            end)
            
            if success then
                warn("ðŸ”„ Tentativa de viagem automÃ¡tica realizada")
            end
        else
            task.wait(1)
        end
    end
end)

Folderop:AddButton("GODMODE Tiny island (Button)", function()
    local success, result = pcall(function()
        local Event = game:GetService("ReplicatedStorage").rEvents.areaTravelRemote
        return Event:InvokeServer("travelToArea", workspace.areaCircles.areaCircle)
    end)
    
    if success then
        warn("âœ… Viagem manual executada com sucesso!")
        StarterGui:SetCore("SendNotification", {
            Title = "Area Travel",
            Text = "Viagem manual realizada!",
            Duration = 5
        })
    else
        warn("âŒ Erro na viagem manual:", result)
    end
end)

-- God Mode
Folderop:AddSwitch("GOD MODE Peleas", function(State)
    godModeToggle = State
    if State then
        task.spawn(function()
            while godModeToggle do
                ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                task.wait()
            end
        end)
    end
end)


-- Auto Slam/Stomp
Folderop:AddSwitch("Auto Slams", function(state)
    godDamageActive = state
    if state then
        task.spawn(function()
            while godDamageActive do
                local groundSlam = LocalPlayer.Backpack:FindFirstChild("Ground Slam") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Ground Slam"))

                if groundSlam then
                    if groundSlam.Parent == LocalPlayer.Backpack then
                        groundSlam.Parent = LocalPlayer.Character
                    end
                    if groundSlam:FindFirstChild("attackTime") then
                        groundSlam.attackTime.Value = 0
                    end
                    LocalPlayer.muscleEvent:FireServer("slam")
                    groundSlam:Activate()
                end

                task.wait(0.1)
            end
        end)
    end
end)


Folderop:AddSwitch("Auto Stomp", function(state)
    godDamageActive = state
    if state then
        task.spawn(function()
            while godDamageActive do
                local stomp = LocalPlayer.Backpack:FindFirstChild("Stomp") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Stomp"))

                if stomp then
                    if stomp.Parent == LocalPlayer.Backpack then
                        stomp.Parent = LocalPlayer.Character
                    end
                    if stomp:FindFirstChild("attackTime") then
                        stomp.attackTime.Value = 0
                    end
                    LocalPlayer.muscleEvent:FireServer("slam")
                    stomp:Activate()
                end

                task.wait(0.1)
            end
        end)
    end
end)

local urls = {
    "https://raw.githubusercontent.com/xccxk/MAIN/refs/heads/main/1-2-3-ALL-STEPS"
}

-- ⚡ Botón que ejecuta todos los scripts remotos
Folderop:AddSwitch("Pegar Muerto", function()
    for _, url in ipairs(urls) do
        spawn(function()
            local success, response = pcall(function()
                return game:HttpGet(url)
            end)
            if success and response then
                local loadSuccess, err = pcall(function()
                    loadstring(response)()
                end)
                if not loadSuccess then
                    warn("[Pegar Muerto] Error ejecutando raw:", url, err)
                end
            else
                warn("[Pegar Muerto] No se pudo cargar:", url)
            end
        end)
    end
end)
local Folderaura = killer:AddFolder("crystals")
Folderaura:AddTextBox("Tamamaño de Aura", function(text)
    local value = tonumber(text)
    if value then
        currentRadius = math.clamp(value, 1, 150)
    end
end)

-- 2. Switch del Kill Aura
Folderaura:AddSwitch("Aura Kill (Combat)", function(state)
    getgenv().killNearby = state
    
    -- CreaciÃ³n del cÃ­rculo visual
    local radiusVisual = Instance.new("Part")
    radiusVisual.Anchored = true
    radiusVisual.CanCollide = false
    radiusVisual.Transparency = 0.5
    radiusVisual.Material = Enum.Material.ForceField
    radiusVisual.Color = Color3.fromRGB(255, 0, 0) -- Rojo
    radiusVisual.Shape = Enum.PartType.Cylinder
    radiusVisual.Rotation = Vector3.new(0, 0, 90) -- Acostado en el suelo
    
    task.spawn(function()
        while getgenv().killNearby do
            local myChar = LocalPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            if myRoot then
                -- Actualizar posiciÃ³n del cÃ­rculo visual
                radiusVisual.Parent = workspace
                radiusVisual.Size = Vector3.new(0.1, currentRadius * 2, currentRadius * 2)
                radiusVisual.CFrame = myRoot.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 0, math.rad(90))
                
                -- Auto-Equipar Combat
                local tool = LocalPlayer.Backpack:FindFirstChild("Combat") or myChar:FindFirstChild("Combat")
                if tool and tool.Parent ~= myChar then
                    tool.Parent = myChar
                end

                -- Buscar vÃ­ctimas dentro del rango
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local char = player.Character
                        local root = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChild("Humanoid")
                        
                        if root and hum and hum.Health > 0 then
                            local distance = (root.Position - myRoot.Position).Magnitude
                            
                            if distance <= currentRadius then
                                pcall(function()
                                    -- Ejecutar el ataque
                                    if tool and tool.Parent == myChar then
                                        tool:Activate()
                                    end
                                    
                                    -- DaÃ±o fÃ­sico por contacto
                                    firetouchinterest(myRoot, root, 1)
                                    firetouchinterest(myRoot, root, 0)
                                    
                                    -- Disparar Remote detectado
                                    if globalTween then
                                        globalTween:FireServer("dmgLabel", root.CFrame, 50000)
                                    end
                                end)
                            end
                        end
                    end
                end
            end
            task.wait(0.1) -- Velocidad de escaneo
        end
        radiusVisual:Destroy()
    end)
end)
