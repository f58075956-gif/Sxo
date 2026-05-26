local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer u

local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
print("Anti-AFK enabled by Lunora HUB PAID")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zchedrick/ON-BENDED-KNEE/refs/heads/main/Helnnahshhss"))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local Window = Library:Window("Muscle Legends || PAID VERSION")

-- ============================================
-- MAIN TAB
-- ============================================
local MainTab = Window:Tab("Main", "rbxassetid://6026568198")

MainTab:Seperator("Client Stats")

local timeLabel = MainTab:Label("Executer Time: 0d 0h 0m 0s")
local fpsLabel = MainTab:Label("FPS : Calculating...")
local pingLabel = MainTab:Label("Ping : Calculating...")
local smoothLabel = MainTab:Label("Smoothness : Calculating...")

local startTime = os.clock()

-- Time tracker
task.spawn(function()
    while task.wait(1) do
        local elapsed = math.floor(os.clock() - startTime)
        timeLabel:Set(string.format(
            "Executer Time: %dd %dh %dm %ds",
            math.floor(elapsed / 86400),
            math.floor(elapsed % 86400 / 3600),
            math.floor(elapsed % 3600 / 60),
            elapsed % 60
        ))
    end
end)

-- FPS tracker
task.spawn(function()
    while task.wait(0.1) do
        fpsLabel:Set("FPS : " .. math.floor(workspace:GetRealPhysicsFPS()))
    end
end)

-- Ping tracker
task.spawn(function()
    while task.wait(0.2) do
        local pingItem = Stats.Network.ServerStatsItem["Data Ping"]
        pingLabel:Set("Ping : " .. pingItem:GetValueString())
    end
end)

-- Smoothness tracker
task.spawn(function()
    while task.wait(0.3) do
        local fps = workspace:GetRealPhysicsFPS()
        local smoothness
        if fps >= 55 then
            smoothness = "Very Smooth ðŸŸ¢"
        elseif fps >= 40 then
            smoothness = "Smooth ðŸŸ¡"
        elseif fps >= 25 then
            smoothness = "Laggy ðŸŸ "
        else
            smoothness = "Very Laggy ðŸ”´"
        end
        smoothLabel:Set("Smoothness : " .. smoothness)
    end
end)

-- ============================================
-- Movement
-- ============================================
MainTab:Seperator("Movement")

MainTab:Slider("WalkSpeed", 0, 500, 16, function(value)
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
end)

MainTab:Slider("JumpPower", 0, 1500, 50, function(value)
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end
end)

-- ============================================
-- Important Features
-- ============================================
MainTab:Seperator("Important")
MainTab:Label("IMPORTANT FEATURES")

MainTab:Toggle("Anti Fling", true, "Prevents knockback / fling", function(state)
    local char = LocalPlayer.Character
    if not char then
        char = LocalPlayer.CharacterAdded:Wait()
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if state then
        if not hrp:FindFirstChild("AntiFling") then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "AntiFling"
            bv.MaxForce = Vector3.new(100000, 0, 100000)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.P = 1250
            bv.Parent = hrp
        end
    else
        local existing = hrp:FindFirstChild("AntiFling")
        if existing then
            existing:Destroy()
        end
    end
end)

local lockPositionEnabled = false
MainTab:Toggle("Lock Position", false, "Freeze your position", function(state)
    lockPositionEnabled = state
    if not state then return end

    task.spawn(function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        while lockPositionEnabled do
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
            hrp.CFrame = CFrame.new(hrp.Position)
            task.wait(0.05)
        end
    end)
end)

MainTab:Toggle("Show Pets", false, "Toggle your pets", function(state)
    if LocalPlayer:FindFirstChild("hidePets") then
        LocalPlayer.hidePets.Value = state
    end
end)

MainTab:Toggle("Show Other Pets", false, "Toggle other players pets", function(state)
    if LocalPlayer:FindFirstChild("showOtherPetsOn") then
        LocalPlayer.showOtherPetsOn.Value = state
    end
end)

-- ============================================
-- Misc Features
-- ============================================
MainTab:Seperator("Misc")

_G.InfJump = false
MainTab:Toggle("Infinite Jump", false, "Unlimited jumping", function(state)
    _G.InfJump = state
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        local char = LocalPlayer.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Water platforms
local waterParts = {}
local platformSize = 2048
local basePosition = Vector3.new(-2, -9.5, -2)

task.spawn(function()
    for x = -5, 5 do
        for z = -5, 5 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(platformSize, 1, platformSize)
            part.Position = basePosition + Vector3.new(x * platformSize, 0, z * platformSize)
            part.Anchored = true
            part.Transparency = 1
            part.CanCollide = true
            part.Parent = workspace
            table.insert(waterParts, part)
        end
    end
end)

MainTab:Toggle("Walk on Water", true, "Walk on water surface", function(state)
    for _, part in pairs(waterParts) do
        if part and part.Parent then
            part.CanCollide = state
        end
    end
end)

MainTab:Toggle("Spin Fortune Wheel", false, "Auto spin", function(state)
    _G.AutoSpin = state
    if not state then return end

    task.spawn(function()
        while _G.AutoSpin do
            pcall(function()
                local remote = ReplicatedStorage.rEvents.openFortuneWheelRemote
                remote:InvokeServer("openFortuneWheel", ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
            end)
            task.wait(1)
        end
    end)
end)

MainTab:Dropdown("Change Time", { "Night", "Day", "Midnight" }, false, function(selection)
    if selection == "Night" then
        Lighting.ClockTime = 0
    elseif selection == "Day" then
        Lighting.ClockTime = 12
    elseif selection == "Midnight" then
        Lighting.ClockTime = 6
    end
end)

-- ============================================
-- FARMING TAB
-- ============================================
local FarmingTab = Window:Tab("Farming", "rbxassetid://10723425539")

FarmingTab:Seperator("Farming")

local fastRebirthEnabled = false
FarmingTab:Toggle("Fast Rebirth", false, nil, function(state)
    fastRebirthEnabled = state
    if not state then return end

    task.spawn(function()
        local function unequipAllPets()
            local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
            if not petsFolder then return end

            for _, folder in pairs(petsFolder:GetChildren()) do
                if folder:IsA("Folder") then
                    for _, pet in pairs(folder:GetChildren()) do
                        pcall(function()
                            ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                        end)
                    end
                end
            end
            task.wait(0.05)
        end

        local function equipPetByName(petName)
            unequipAllPets()
            local uniqueFolder = LocalPlayer.petsFolder:FindFirstChild("Unique")
            if not uniqueFolder then return end

            for _, pet in pairs(uniqueFolder:GetChildren()) do
                if pet.Name == petName then
                    pcall(function()
                        ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
                    end)
                end
            end
        end

        local function findMachine(machineName)
            local machinesFolder = workspace:FindFirstChild("machinesFolder")
            if machinesFolder then
                local machine = machinesFolder:FindFirstChild(machineName)
                if machine then return machine end
            end

            for _, folder in pairs(workspace:GetChildren()) do
                if folder:IsA("Folder") and folder.Name:find("machines") then
                    local machine = folder:FindFirstChild(machineName)
                    if machine then return machine end
                end
            end
            return nil
        end

        local function pressE()
            VirtualInputManager:SendKeyEvent(true, "E", false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, "E", false, game)
        end

        while fastRebirthEnabled do
            equipPetByName("Swift Samurai")

            for _ = 1, 15 do
                if not fastRebirthEnabled then break end
                pcall(function()
                    LocalPlayer.muscleEvent:FireServer("rep")
                end)
            end
            task.wait(0.1)

            if not fastRebirthEnabled then break end

            equipPetByName("Tribal Overlord")

            local machine = findMachine("Jungle Bar Lift")
            if machine and machine:FindFirstChild("interactSeat") then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = machine.interactSeat.CFrame * CFrame.new(0, 3, 0)
                    task.wait(0.1)

                    pressE()

                    if char:FindFirstChild("Humanoid") and char.Humanoid.Sit then
                        local rebirthsBefore = LocalPlayer.leaderstats.Rebirths.Value
                        pcall(function()
                            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                        end)
                        task.wait(0.15)
                    end
                end
            end

            task.wait(0.2)
        end
    end)
end)

local ultimateFastStrengthEnabled = false
FarmingTab:Toggle("Ultimate Fast Strength", false, nil, function(state)
    ultimateFastStrengthEnabled = state
    getgenv().isGrinding = state
    if not state then return end

    task.spawn(function()
        while ultimateFastStrengthEnabled do
            for _ = 1, 5 do
                for _ = 1, 4000 do
                    if not ultimateFastStrengthEnabled then break end
                    pcall(function()
                        LocalPlayer.muscleEvent:FireServer("rep")
                    end)
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- ============================================
-- Misc Farming Features
-- ============================================
FarmingTab:Seperator("Misc")

FarmingTab:Toggle("Hide Frames", false, "Hide ReplicatedStorage Frames", function(state)
    for _, obj in pairs(ReplicatedStorage:GetChildren()) do
        if obj.Name:match("Frame$") then
            pcall(function()
                obj.Visible = not state
            end)
        end
    end
end)

FarmingTab:Button("Anti Lag", function()
    -- Remove GUIs
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            gui:Destroy()
        end
    end

    -- Remove particles
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            obj:Destroy()
        end
    end

    -- Remove lights
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            obj:Destroy()
        end
    end

    -- Replace sky with dark sky
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end

    local darkSky = Instance.new("Sky")
    darkSky.Name = "DarkSky"
    darkSky.SkyboxBk = "rbxassetid://0"
    darkSky.SkyboxDn = "rbxassetid://0"
    darkSky.SkyboxFt = "rbxassetid://0"
    darkSky.SkyboxLf = "rbxassetid://0"
    darkSky.SkyboxRt = "rbxassetid://0"
    darkSky.SkyboxUp = "rbxassetid://0"
    darkSky.Parent = Lighting

    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.TimeOfDay = "00:00:00"
    Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    Lighting.Ambient = Color3.new(0, 0, 0)
    Lighting.FogColor = Color3.new(0, 0, 0)
    Lighting.FogEnd = 100

    task.spawn(function()
        while true do
            task.wait(5)
            if not Lighting:FindFirstChild("DarkSky") then
                darkSky:Clone().Parent = Lighting
            end
            Lighting.Brightness = 0
            Lighting.ClockTime = 0
            Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
            Lighting.Ambient = Color3.new(0, 0, 0)
            Lighting.FogColor = Color3.new(0, 0, 0)
            Lighting.FogEnd = 100
        end
    end)
end)

-- ============================================
-- Gamepass Unlock
-- ============================================
FarmingTab:Seperator("Farming")

FarmingTab:Toggle("Unlock AutoLift Gamepass", false, "Unlock the AutoLift Game Pass for free", function(state)
    if not state then return end

    local fetchResult = pcall(function()
        return ReplicatedStorage:WaitForChild("gamepassIds", 2)
    end)

    local gamepassIds = ReplicatedStorage:FindFirstChild("gamepassIds")
    if not fetchResult or not gamepassIds then
        warn("gamepassIds not found in ReplicatedStorage")
        return
    end

    if not LocalPlayer then return end

    local ownedFolder = LocalPlayer:FindFirstChild("ownedGamepasses")
    if not ownedFolder then
        ownedFolder = Instance.new("Folder")
        ownedFolder.Name = "ownedGamepasses"
        ownedFolder.Parent = LocalPlayer
    end

    for _, gp in pairs(gamepassIds:GetChildren()) do
        local intVal = Instance.new("IntValue")
        intVal.Name = gp.Name
        intVal.Value = gp.Value or 1
        intVal.Parent = ownedFolder
    end
end)

-- ============================================
-- Auto Exercises
-- ============================================
FarmingTab:Seperator("Auto Exercises")

local function createAutoExercise(exerciseName)
    FarmingTab:Toggle("Auto " .. exerciseName, false, "Automatically do " .. exerciseName, function(state)
        local globalKey = "Auto" .. exerciseName:gsub("%s", "")
        getgenv()[globalKey] = state

        task.spawn(function()
            while getgenv()[globalKey] do
                if LocalPlayer and LocalPlayer:FindFirstChild("Backpack") then
                    local tool = LocalPlayer.Backpack:FindFirstChild(exerciseName)
                    if tool and LocalPlayer.Character then
                        pcall(function()
                            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:EquipTool(tool)
                            end
                        end)
                    end
                    pcall(function()
                        LocalPlayer.muscleEvent:FireServer("rep")
                    end)
                    task.wait(0.1)
                end
            end
        end)
    end)
end

createAutoExercise("Weight")
createAutoExercise("Pushups")
createAutoExercise("Handstands")
createAutoExercise("Situps")
createAutoExercise("Punch")

-- ============================================
-- Fast Tools
-- ============================================
FarmingTab:Toggle("Fast Tools", false, "Accelerates all tools", function(state)
    getgenv().FastTools = state

    local toolSettings = {
        { "Punch", "attackTime", state and 0 or 0.35 },
        { "Ground Slam", "attackTime", state and 0 or 6 },
        { "Stomp", "attackTime", state and 0 or 7 },
        { "Handstands", "repTime", state and 0 or 1 },
        { "Pushups", "repTime", state and 0 or 1 },
        { "Weight", "repTime", state and 0 or 1 },
        { "Situps", "repTime", state and 0 or 1 },
    }

    task.spawn(function()
        if not LocalPlayer then return end
        local backpack = LocalPlayer:WaitForChild("Backpack")

        for _, settings in ipairs(toolSettings) do
            local toolName, attribute, value = settings[1], settings[2], settings[3]

            local toolInBackpack = backpack:FindFirstChild(toolName)
            if toolInBackpack and toolInBackpack:FindFirstChild(attribute) then
                pcall(function()
                    toolInBackpack[attribute].Value = value
                end)
            end

            if LocalPlayer.Character then
                local toolInChar = LocalPlayer.Character:FindFirstChild(toolName)
                if toolInChar and toolInChar:FindFirstChild(attribute) then
                    pcall(function()
                        toolInChar[attribute].Value = value
                    end)
                end
            end
        end
    end)
end)

-- ============================================
-- Gym Teleports
-- ============================================
FarmingTab:Seperator("Gym Teleports")

local gymLocations = {
    ["Jungle Bench Press"] = CFrame.new(-8173, 64, 1898),
    ["Jungle Squat"]       = CFrame.new(-8352, 34, 2878),
    ["Jungle Pull Ups"]    = CFrame.new(-8666, 34, 2070),
    ["Jungle Boulder"]     = CFrame.new(-8621, 34, 2684),
}

for gymName, gymCFrame in pairs(gymLocations) do
    local targetCFrame = gymCFrame
    FarmingTab:Button(gymName, function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        char:WaitForChild("HumanoidRootPart").CFrame = targetCFrame
        task.wait(0.2)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

-- ============================================
-- Rebirthing
-- ============================================
FarmingTab:Seperator("Rebirthing")

local rebirthTarget = 1
local targetRebirthToggle
local infiniteRebirthToggle

FarmingTab:Slider("Rebirth Target", "Enter target rebirths", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        rebirthTarget = num
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Objetivo Actualizado",
            Text = "Nuevo objetivo: " .. tostring(rebirthTarget) .. " renacimientos",
            Duration = 3,
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "Put a number larger than 0",
            Duration = 3,
        })
    end
end)

targetRebirthToggle = FarmingTab:Toggle("Auto Rebirth Target", false, "Automatically rebirth until reaching the goal", function(state)
    _G.targetRebirthActive = state
    if state then
        if _G.infiniteRebirthActive and infiniteRebirthToggle then
            infiniteRebirthToggle:Set(false)
            _G.infiniteRebirthActive = false
        end
        task.spawn(function()
            while _G.targetRebirthActive do
                if LocalPlayer.leaderstats.Rebirths.Value >= rebirthTarget then
                    targetRebirthToggle:Set(false)
                    _G.targetRebirthActive = false
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Objetivo Alcanzado!",
                        Text = "Has alcanzado " .. tostring(rebirthTarget) .. " renacimientos",
                        Duration = 5,
                    })
                    break
                else
                    pcall(function()
                        ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                end
                task.wait(0.1)
            end
        end)
    end
end)

infiniteRebirthToggle = FarmingTab:Toggle("Auto Rebirth (Infinitely)", false, "Rebirth infinitely", function(state)
    _G.infiniteRebirthActive = state
    if state then
        if _G.targetRebirthActive and targetRebirthToggle then
            targetRebirthToggle:Set(false)
            _G.targetRebirthActive = false
        end
        task.spawn(function()
            while _G.infiniteRebirthActive do
                pcall(function()
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end)
                task.wait(0.1)
            end
        end)
    end
end)

FarmingTab:Toggle("Auto Size 1", false, "Change size to 1 automatically", function(state)
    _G.autoSizeActive = state
    if state then
        task.spawn(function()
            while _G.autoSizeActive do
                pcall(function()
                    ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                end)
                task.wait()
            end
        end)
    end
end)

FarmingTab:Toggle("Auto Teleport to Muscle King", false, "TP to Muscle King", function(state)
    _G.teleportActive = state
    if state then
        task.spawn(function()
            while _G.teleportActive do
                local char = LocalPlayer.Character
                if char then
                    char:MoveTo(Vector3.new(-8646, 17, -5738))
                end
                task.wait()
            end
        end)
    end
end)
-- ============================================
-- AUTO EAT PROTEIN EGG
-- ============================================
FarmingTab:Seperator("Auto Eat Protein Egg")

local autoEat60Min = false
FarmingTab:Toggle("Auto Eat Egg | 60 Minutes", false, "Automatically eat protein egg every 60 minutes", function(state)
    autoEat60Min = state
end)

local autoEat30Min = false
FarmingTab:Toggle("Auto Eat Egg | 30 Minutes", false, "Automatically eat protein egg every 30 minutes", function(state)
    autoEat30Min = state
end)

local function eatProteinEgg()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not char then return end

    local egg = backpack:FindFirstChild("Protein Egg")
    if egg then
        egg.Parent = char
        pcall(function()
            egg:Activate()
        end)
    end
end

task.spawn(function()
    while true do
        if autoEat60Min then
            eatProteinEgg()
            task.wait(3600)
        elseif autoEat30Min then
            eatProteinEgg()
            task.wait(1800)
        else
            task.wait(1)
        end
    end
end)

-- ============================================
-- GLITCHING TAB
-- ============================================
local GlitchingTab = Window:Tab("Glitching", "rbxassetid://10734897956")

GlitchingTab:Seperator("Tool + Rock Combo Farming")

local function createToolRockCombo(toolName, toggleTitle)
    GlitchingTab:Toggle(toggleTitle, false, "Auto " .. toolName .. " + Jungle Rock", function(state)
        getgenv().autoFarm = state
        _G["Auto" .. toolName] = state
        getgenv().autoPunchNoAnim = state
        getgenv().selectrock = "Ancient Jungle Rock"

        if not state then return end

        task.spawn(function()
            while getgenv().autoFarm do
                task.wait(0.01)
                local char = LocalPlayer.Character
                if not char then return end

                if _G["Auto" .. toolName] then
                    local tool = LocalPlayer.Backpack:FindFirstChild(toolName)
                    if tool then
                        local humanoid = char:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            pcall(function()
                                humanoid:EquipTool(tool)
                                LocalPlayer.muscleEvent:FireServer("rep")
                            end)
                        end

                        if getgenv().autoPunchNoAnim then
                            local punchTool = LocalPlayer.Backpack:FindFirstChild("Punch")
                            if punchTool then
                                punchTool.Parent = char
                                pcall(function()
                                    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                                    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                                end)

                                if LocalPlayer:FindFirstChild("Durability") and LocalPlayer.Durability.Value >= 10000000 then
                                    for _, obj in pairs(workspace.machinesFolder:GetDescendants()) do
                                        if obj.Name == "neededDurability" and obj.Value == 10000000 then
                                            local rock = obj.Parent:FindFirstChild("Rock")
                                            if rock and char:FindFirstChild("RightHand") and char:FindFirstChild("LeftHand") then
                                                firetouchinterest(rock, char.RightHand, 0)
                                                firetouchinterest(rock, char.RightHand, 1)
                                                firetouchinterest(rock, char.LeftHand, 0)
                                                firetouchinterest(rock, char.LeftHand, 1)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)
end

createToolRockCombo("Pushups", "Pushups + Jungle Rock")
createToolRockCombo("Situps", "Situps + Jungle Rock")
createToolRockCombo("Handstands", "Handstands + Jungle Rock")

-- ============================================
-- ROCK FARMING
-- ============================================
GlitchingTab:Seperator("Rock Farming")

local function equipAndPunch()
    if not LocalPlayer.Character then return end
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool.Name == "Punch" then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(tool)
            end
        end
    end
    pcall(function()
        LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
        LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
    end)
end

local function farmRockByDurability(requiredDurability)
    while _G.RockFarm do
        task.wait()
        if not LocalPlayer:FindFirstChild("Durability") then return end
        if LocalPlayer.Durability.Value < requiredDurability then return end

        for _, obj in pairs(workspace.machinesFolder:GetDescendants()) do
            if obj.Name == "neededDurability" and obj.Value == requiredDurability then
                local rock = obj.Parent:FindFirstChild("Rock")
                local char = LocalPlayer.Character
                if rock and char and char:FindFirstChild("LeftHand") and char:FindFirstChild("RightHand") then
                    firetouchinterest(rock, char.RightHand, 0)
                    firetouchinterest(rock, char.RightHand, 1)
                    firetouchinterest(rock, char.LeftHand, 0)
                    firetouchinterest(rock, char.LeftHand, 1)
                    equipAndPunch()
                end
            end
        end
    end
end

local function createRockToggle(toggleName, requiredDurability)
    GlitchingTab:Toggle(toggleName, false, "Auto farm " .. toggleName, function(state)
        _G.RockFarm = state
        if state then
            task.spawn(function()
                farmRockByDurability(requiredDurability)
            end)
        end
    end)
end

createRockToggle("Tiny Rock", 0)
createRockToggle("Starter Rock", 100)
createRockToggle("Legend Beach Rock", 5000)
createRockToggle("Frozen Rock", 150000)
createRockToggle("Mythical Rock", 400000)
createRockToggle("Eternal Rock", 750000)
createRockToggle("Legend Rock", 1000000)
createRockToggle("Muscle King Rock", 5000000)
createRockToggle("Jungle Rock", 10000000)

-- ============================================
-- STATUS TAB
-- ============================================
local StatusTab = Window:Tab("Status", "rbxassetid://10709773755")

local statsBox = StatusTab:StatusBox("Status", "Initializing stats monitor...\n")

local function formatNumberShort(num, decimals)
    decimals = decimals or 2
    local absNum = math.abs(num)
    local sign = num < 0 and "-" or ""

    local function fmt(value)
        return string.format("%." .. decimals .. "f", value)
    end

    if absNum >= 1e+18 then return sign .. fmt(num / 1e+18) .. "Qi" end
    if absNum >= 1e+15 then return sign .. fmt(num / 1e+15) .. "Qa" end
    if absNum >= 1e+12 then return sign .. fmt(num / 1e+12) .. "T" end
    if absNum >= 1e+9 then return sign .. fmt(num / 1e+9) .. "B" end
    if absNum >= 1e+6 then return sign .. fmt(num / 1e+6) .. "M" end
    if absNum >= 1e+3 then return sign .. fmt(num / 1e+3) .. "K" end
    return sign .. tostring(num)
end

local function getStatValue(player, statName)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats and leaderstats:FindFirstChild(statName) then
        return leaderstats[statName]
    end
    if player:FindFirstChild(statName) then
        return player[statName]
    end
    for _, child in pairs(player:GetChildren()) do
        if child:IsA("Folder") and child:FindFirstChild(statName) then
            return child[statName]
        end
    end
    return nil
end

-- ============================================
-- SESSION MONITOR
-- ============================================
local leaderstats = LocalPlayer:WaitForChild("leaderstats")

local function formatNumber(num)
    if not num then return "0" end
    if num >= 1e+18 then return string.format("%.2fQi", num / 1e+18) end
    if num >= 1e+15 then return string.format("%.2fQa", num / 1e+15) end
    if num >= 1e+12 then return string.format("%.2fT", num / 1e+12) end
    if num >= 1e+9 then return string.format("%.2fB", num / 1e+9) end
    if num >= 1e+6 then return string.format("%.2fM", num / 1e+6) end
    if num >= 1e+3 then return string.format("%.2fK", num / 1e+3) end
    return string.format("%.2f", num)
end

local function formatTime(seconds)
    return string.format(
        "%dd %dh %dm %02ds",
        math.floor(seconds / 86400),
        math.floor(seconds % 86400 / 3600),
        math.floor(seconds % 3600 / 60),
        seconds % 60
    )
end

local function calculatePace(gained, seconds)
    if seconds <= 0 then return 0, 0 end
    return gained / (seconds / 3600), gained / (seconds / 86400)
end

local sessionBox = StatusTab:StatusBox("Session Monitor", "Initializing session monitor...\n")
local sessionStart = os.time()
local startStrength = 0
local startDurability = 0
local startRebirths = 0

local function initializeSessionStart()
    if leaderstats:FindFirstChild("Strength") then
        startStrength = leaderstats.Strength.Value
    end
    if LocalPlayer:FindFirstChild("Durability") then
        startDurability = LocalPlayer.Durability.Value
    end
    if leaderstats:FindFirstChild("Rebirths") then
        startRebirths = leaderstats.Rebirths.Value
    end
end

initializeSessionStart()

local function updateSessionMonitor()
    local currentStrength = leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or 0
    local currentDurability = LocalPlayer:FindFirstChild("Durability") and LocalPlayer.Durability.Value or 0
    local currentRebirths = leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0

    local gainedStrength = currentStrength - startStrength
    local gainedDurability = currentDurability - startDurability
    local gainedRebirths = currentRebirths - startRebirths

    local sessionSeconds = os.time() - sessionStart
    local strengthPerHour, strengthPerDay = calculatePace(gainedStrength, sessionSeconds)
    local durabilityPerHour, durabilityPerDay = calculatePace(gainedDurability, sessionSeconds)
    local rebirthsPerHour, rebirthsPerDay = calculatePace(gainedRebirths, sessionSeconds)

    local infoText = string.format(
        "Session Time: %s\n\nRebirth Pace: %s / Hour | %s / Day\nStrength Pace: %s / Hour | %s / Day\nDurability Pace: %s / Hour | %s / Day\n\nGained Stats:\nStrength: %s | Gained: %s\nDurability: %s | Gained: %s\nRebirths: %s | Gained: %s\n\nLast Updated: %s",
        formatTime(sessionSeconds),
        formatNumber(rebirthsPerHour), formatNumber(rebirthsPerDay),
        formatNumber(strengthPerHour), formatNumber(strengthPerDay),
        formatNumber(durabilityPerHour), formatNumber(durabilityPerDay),
        formatNumber(currentStrength), formatNumber(gainedStrength),
        formatNumber(currentDurability), formatNumber(gainedDurability),
        formatNumber(currentRebirths), formatNumber(gainedRebirths),
        os.date("%c")
    )

    pcall(function()
        sessionBox:Set(infoText)
    end)
end

task.spawn(function()
    while true do
        updateSessionMonitor()
        task.wait(0.1)
    end
end)

-- ============================================
-- TELEPORT TAB
-- ============================================
local TeleportTab = Window:Tab("Teleport", "rbxassetid://10734886004")

local function teleportToLocation(position, notificationText)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char then
        char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(position)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Teleporte",
            Text = notificationText,
            Duration = 3,
        })
    end
end

local teleportLocations = {
    { name = "Spawn",            pos = Vector3.new(2, 8, 115),                       text = "Teleportando ao Inicio" },
    { name = "Secret Area",      pos = Vector3.new(1947, 2, 6191),                   text = "Teleportando a Ãrea Secreta" },
    { name = "Tiny Island",      pos = Vector3.new(-34, 7, 1903),                    text = "Teleportando a Ãrea Pequena" },
    { name = "Teleport Frozen",  pos = Vector3.new(-2600.00244, 3.67686558, -403.884369), text = "Teleportando a Ãrea Congelada" },
    { name = "Mythical",         pos = Vector3.new(2255, 7, 1071),                   text = "Teleportando a Ãrea MÃ­stica" },
    { name = "Inferno",          pos = Vector3.new(-6768, 7, -1287),                 text = "Teleportando a Ãrea Inferno" },
    { name = "Legend",           pos = Vector3.new(4604, 991, -3887),                text = "Teleportando a Ãrea das Lendas" },
    { name = "Muscle King Gym",  pos = Vector3.new(-8646, 17, -5738),                text = "Teleportando ao Rei do Musculo" },
    { name = "Jungle",           pos = Vector3.new(-8659, 6, 2384),                  text = "Teleportando a Selva" },
    { name = "Brawl Lava",       pos = Vector3.new(4471, 119, -8836),                text = "Teleportando a Ilha de Lava" },
    { name = "Brawl Desert",     pos = Vector3.new(960, 17, -7398),                  text = "Teleportando a Ilha de Deserto" },
    { name = "Brawl Regular",    pos = Vector3.new(-1849, 20, -6335),                text = "Teleportando a Combate de Praia" },
}

for _, loc in ipairs(teleportLocations) do
    local cachedPos = loc.pos
    local cachedText = loc.text
    TeleportTab:Button(loc.name, function()
        teleportToLocation(cachedPos, cachedText)
    end)
end

-- ============================================
-- KILLING TAB
-- ============================================
local KillingTab = Window:Tab("Killing", "rbxassetid://10709769508")
local RunService = game:GetService("RunService")
local StarterPack = game:GetService("StarterPack")

KillingTab:Label("Whitelisting")

local killWhitelist = {}

KillingTab:Textbox("Whitelist", nil, function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer then
        killWhitelist[targetPlayer.Name] = true
        Library:Alert("Whitelisted: " .. targetPlayer.Name)
    else
        Library:Alert("Player not found: " .. tostring(playerName))
    end
end)

KillingTab:Textbox("UnWhitelist", nil, function(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if targetPlayer then
        killWhitelist[targetPlayer.Name] = nil
        Library:Alert("Removed from whitelist: " .. targetPlayer.Name)
    else
        Library:Alert("Player not found: " .. tostring(playerName))
    end
end)

KillingTab:Seperator("Auto Killing")

local autoKillEnabled = false
KillingTab:Toggle("Auto Kill", false, "Automatically attack non-whitelisted players", function(state)
    autoKillEnabled = state
    if not state then return end

    task.spawn(function()
        while autoKillEnabled do
            for _, target in ipairs(Players:GetPlayers()) do
                if target ~= LocalPlayer and not killWhitelist[target.Name] then
                    local targetChar = target.Character
                    local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        local myChar = LocalPlayer.Character
                        local myRightHand = myChar and myChar:FindFirstChild("RightHand")
                        local myLeftHand = myChar and myChar:FindFirstChild("LeftHand")
                        if myRightHand and myLeftHand then
                            pcall(function()
                                firetouchinterest(myRightHand, targetHRP, 1)
                                firetouchinterest(myLeftHand, targetHRP, 1)
                                firetouchinterest(myRightHand, targetHRP, 0)
                                firetouchinterest(myLeftHand, targetHRP, 0)
                            end)
                        end
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- ============================================
-- KILL TARGETING
-- ============================================
local targetPet = nil
local targetMode = nil
local targetHitbox = nil
local killTargets = {}

KillingTab:Label("Kill Targeting")
KillingTab:Label("Target Selection")

KillingTab:Dropdown("Select Target Mode", {}, "Choose target mode", function(value)
    if killTargets[value] then
        targetMode = killTargets[value]
    end
end)

KillingTab:Dropdown("Select Hitbox Size", {}, "Choose hitbox size", function(value)
    if killTargets[value] then
        targetHitbox = killTargets[value]
    end
end)

KillingTab:Dropdown("Pet Selection", {}, "Select pet to use", function(petName)
    targetPet = petName
    local petsFolder = LocalPlayer:WaitForChild("petsFolder")

    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                pcall(function()
                    ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                end)
            end
        end
    end

    task.wait(0.2)

    local petsToEquip = {}
    local uniqueFolder = petsFolder:FindFirstChild("Unique")
    if uniqueFolder then
        for _, pet in pairs(uniqueFolder:GetChildren()) do
            if pet.Name == petName then
                table.insert(petsToEquip, pet)
            end
        end
    end

    for i = 1, math.min(#petsToEquip, 8) do
        pcall(function()
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
        end)
        task.wait(0.1)
    end
end)

-- ============================================
-- FAST PUNCH
-- ============================================
KillingTab:Toggle("Fast Punch", false, "Speeds up punch attack rate", function(state)
    _G.FastPunch = state
    if not state then return end

    task.spawn(function()
        while _G.FastPunch do
            if LocalPlayer.Character then
                local punchTool = LocalPlayer.Character:FindFirstChild("Punch")
                    or LocalPlayer.Backpack:FindFirstChild("Punch")

                if punchTool then
                    punchTool.Parent = LocalPlayer.Character
                    if punchTool:FindFirstChild("attackTime") then
                        punchTool.attackTime.Value = 0
                    end
                    pcall(function()
                        punchTool:Activate()
                    end)
                end
                task.wait(0.0001)
            end
        end
    end)
end)

-- ============================================
-- SUNSET WORLD (Remove Effects)
-- ============================================
KillingTab:Button("Sunset World", function()
    pcall(function()
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Part") then
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Smoke") then
                        pcall(function()
                            child:Destroy()
                        end)
                    end
                end
            end
        end

        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end
    end)

    pcall(function()
        Lighting.ClockTime = 18
        Lighting.Brightness = 1.5
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 80)
        Lighting.FogColor = Color3.fromRGB(200, 120, 100)
        Lighting.FogEnd = 500

        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("Sky") then
                pcall(function()
                    obj:Destroy()
                end)
            end
        end

        local sunsetSky = Instance.new("Sky")
        sunsetSky.Name = "SunsetSky"
        sunsetSky.SkyboxBk = "rbxassetid://131889017"
        sunsetSky.SkyboxDn = "rbxassetid://131889017"
        sunsetSky.SkyboxFt = "rbxassetid://131889017"
        sunsetSky.SkyboxLf = "rbxassetid://131889017"
        sunsetSky.SkyboxRt = "rbxassetid://131889017"
        sunsetSky.SkyboxUp = "rbxassetid://131889017"
        sunsetSky.SunAngularSize = 10
        sunsetSky.MoonAngularSize = 0
        sunsetSky.SunTextureId = "rbxassetid://644432992"
        sunsetSky.Parent = Lighting
    end)
end)

-- ============================================
-- BLOCK PUNCH ANIMATIONS
-- ============================================
local blockedAnimationIds = {
    ["rbxassetid://3638729053"] = true,
    ["rbxassetid://3638767427"] = true,
}

local function shouldBlockAnimation(track)
    if not track.Animation then return false end
    if blockedAnimationIds[track.Animation.AnimationId] then return true end
    local name = track.Name:lower()
    return name:match("punch") or name:match("attack") or name:match("right")
end

local function stopBlockedAnimations()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        if shouldBlockAnimation(track) then
            track:Stop()
        end
    end

    if not _G.AnimBlockConnection then
        _G.AnimBlockConnection = humanoid.AnimationPlayed:Connect(function(track)
            if shouldBlockAnimation(track) then
                track:Stop()
            end
        end)
    end
end

local function setupToolOverride(tool)
    if not tool then return end
    if tool.Name ~= "Punch" and not tool.Name:match("Attack") and not tool.Name:match("Right") then return end
    if tool:GetAttribute("ActivatedOverride") then return end

    tool:SetAttribute("ActivatedOverride", true)
    if not _G.ToolConnections then _G.ToolConnections = {} end

    _G.ToolConnections[tool] = tool.Activated:Connect(function()
        task.wait(0.05)
        stopBlockedAnimations()
    end)
end

local function setupAllTools()
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        setupToolOverride(tool)
    end
    if LocalPlayer.Character then
        for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
            if tool:IsA("Tool") then
                setupToolOverride(tool)
            end
        end
    end

    if not _G.BackpackAddedConnection then
        _G.BackpackAddedConnection = LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
            if tool:IsA("Tool") then
                task.wait(0.1)
                setupToolOverride(tool)
            end
        end)
    end

    if not _G.CharacterToolAddedConnection and LocalPlayer.Character then
        _G.CharacterToolAddedConnection = LocalPlayer.Character.ChildAdded:Connect(function(tool)
            if tool:IsA("Tool") then
                task.wait(0.1)
                setupToolOverride(tool)
            end
        end)
    end
end

KillingTab:Toggle("Block Punch Animations", false, "Removes punch animations", function(state)
    if state then
        stopBlockedAnimations()
        setupAllTools()

        if not _G.AnimMonitorConnection then
            _G.AnimMonitorConnection = RunService.Heartbeat:Connect(function()
                if tick() % 0.5 < 0.01 then
                    stopBlockedAnimations()
                end
            end)
        end

        if not _G.CharacterAddedConnection then
            _G.CharacterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(1)
                stopBlockedAnimations()
                setupAllTools()
                if _G.CharacterToolAddedConnection then
                    _G.CharacterToolAddedConnection:Disconnect()
                end
                _G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(tool)
                    if tool:IsA("Tool") then
                        task.wait(0.1)
                        setupToolOverride(tool)
                    end
                end)
            end)
        end
    end
end)

local function disableAllAnimBlockers()
    local connectionsToCleanup = {
        "AnimBlockConnection", "AnimMonitorConnection",
        "BackpackAddedConnection", "CharacterToolAddedConnection",
        "CharacterAddedConnection",
    }
    for _, connName in ipairs(connectionsToCleanup) do
        if _G[connName] then
            _G[connName]:Disconnect()
            _G[connName] = nil
        end
    end
    if _G.ToolConnections then
        for _, conn in pairs(_G.ToolConnections) do
            if conn then conn:Disconnect() end
        end
        _G.ToolConnections = nil
    end
end

KillingTab:Button("Reset Character", function()
    pcall(function()
        if LocalPlayer:IsA("Player") then
            local loaded = pcall(function()
                LocalPlayer:LoadCharacter()
            end)
            if not loaded then
                pcall(function()
                    game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
                end)
            end
        end
    end)
end)

KillingTab:Button("Recover Animations", function()
    disableAllAnimBlockers()
    Library:Alert("Recovered punch animations")
end)

KillingTab:Button("NaN Size Exploit", function()
    pcall(function()
        local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
        if rEvents then
            local sizeRemote = rEvents:FindFirstChild("changeSpeedSizeRemote")
            if sizeRemote and sizeRemote.InvokeServer then
                pcall(function()
                    sizeRemote:InvokeServer("changeSize", 0 / 0)
                end)
            end
        end
    end)
    Library:Alert("Sent NaN size request")
end)

local connections = {}
local globalState = {}
local windowMinimized = false

local function disconnectByName(name)
    local conn = connections[name]
    if not conn then return end
    pcall(function()
        if typeof(conn) == "RBXScriptConnection" and conn.Disconnect then
            conn:Disconnect()
        elseif type(conn) == "table" and conn.Disconnect then
            conn:Disconnect()
        end
    end)
    connections[name] = nil
end

local function disconnectAll()
    for name, _ in pairs(connections) do
        connections[name] = nil
    end
end

local function disableAllAutoFeatures()
    _G.AutoPunchToggle = false
    _G.AutoProteinEgg = false
    getgenv().AntiFlyActive = false
    for name, _ in pairs(connections) do
        disconnectByName(name)
    end
    connections = {}
    disconnectAll()
end

local function startTinyIslandLoop()
    globalState.TinyIslandLoop = true
    task.spawn(function()
        local targetCFrame = CFrame.new(-37.1, 9.2, 1919)
        while globalState.TinyIslandLoop and not windowMinimized do
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = targetCFrame
                end
            end)
            task.wait(0.2)
        end
    end)
end

local function startAutoProteinEgg()
    _G.AutoProteinEgg = true
    globalState.ProteinEgg = true

    task.spawn(function()
        local eggName = "Protein Egg"
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        if not char then return end

        local function makePartsVisible(obj)
            for _, part in pairs(obj:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.Transparency = 0 end)
                    pcall(function() part.LocalTransparencyModifier = 0 end)
                end
            end
        end

        local function findEgg()
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                local egg = backpack:FindFirstChild(eggName)
                if egg then return egg end
            end
            local egg = StarterPack:FindFirstChild(eggName)
            if egg then return egg end
            egg = ReplicatedStorage:FindFirstChild(eggName)
            return egg
        end

        local function equipEgg(egg)
            local character = LocalPlayer.Character
            if not character then return end
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid then return end

            pcall(function()
                humanoid:EquipTool(egg)
            end)
            task.wait(0.1)

            if not character:FindFirstChild(eggName) then
                pcall(function()
                    egg.Parent = character
                end)
                task.wait(0.1)
            end

            local equipped = character:FindFirstChild(eggName)
            if equipped then
                makePartsVisible(equipped)
            end
        end

        local function disableScripts(obj)
            for _, item in pairs(obj:GetDescendants()) do
                if item:IsA("Script") then
                    pcall(function() item:Destroy() end)
                elseif item:IsA("LocalScript") then
                    pcall(function() item.Disabled = true end)
                elseif item:IsA("RemoteEvent") then
                    pcall(function()
                        item.FireServer = function() end
                    end)
                end
            end
        end

        local function processProteinEgg()
            if not _G.AutoProteinEgg then return end
            local character = LocalPlayer.Character
            if not character then return end

            local egg = findEgg()
            if egg then
                equipEgg(egg)
                disableScripts(egg)
            end
        end

        local function monitorContainer(container)
            if not container then return end
            for _, tool in pairs(container:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == eggName then
                    processProteinEgg()
                end
            end
            return container.ChildAdded:Connect(function(child)
                if child:IsA("Tool") and child.Name == eggName then
                    task.defer(function()
                        processProteinEgg()
                    end)
                end
            end)
        end

        disconnectByName("MonitorBackpack")
        disconnectByName("MonitorCharacter")
        connections.MonitorBackpack = monitorContainer(
            LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:WaitForChild("Backpack")
        )
        connections.MonitorCharacter = monitorContainer(LocalPlayer.Character)

        disconnectByName("CharacterAddedProtein")
        connections.CharacterAddedProtein = LocalPlayer.CharacterAdded:Connect(function(newChar)
            task.wait(1)
            disconnectByName("MonitorBackpack")
            disconnectByName("MonitorCharacter")
            connections.MonitorBackpack = monitorContainer(
                LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:WaitForChild("Backpack")
            )
            connections.MonitorCharacter = monitorContainer(newChar)
            processProteinEgg()
        end)

        disconnectByName("BackpackChildProtein")
        local backpackRef = LocalPlayer:WaitForChild("Backpack")
        connections.BackpackChildProtein = backpackRef.ChildAdded:Connect(function(child)
            if _G.AutoProteinEgg and child.Name == eggName then
                task.wait(0.2)
                processProteinEgg()
            end
        end)

        while _G.AutoProteinEgg and globalState.ProteinEgg do
            pcall(processProteinEgg)
            task.wait(0.5)
        end
    end)
end

local function startAutoPunch()
    _G.AutoPunchToggle = true
    globalState.AutoPunch = true

    task.spawn(function()
        local backpack = LocalPlayer:WaitForChild("Backpack")
        local punchHand = "rightHand"

        local function getMuscleEvent()
            return LocalPlayer:FindFirstChild("muscleEvent")
        end

        disconnectByName("CharAddedForAutoPunch")
        connections.CharAddedForAutoPunch = LocalPlayer.CharacterAdded:Connect(function(newChar)
            if windowMinimized then return end
            if connections.HumanoidResetHook ~= nil then return end

            local humanoid = newChar:FindFirstChildOfClass("Humanoid")
            if humanoid then
                disconnectByName("ResetDeath")
                connections.ResetDeath = humanoid.Died:Connect(function()
                    task.wait(0.5)
                    disableAllAutoFeatures()
                end)
            end
        end)

        disconnectByName("BackpackChildForAutoPunch")
        connections.BackpackChildForAutoPunch = LocalPlayer.ChildAdded:Connect(function(child)
            if child.Name == "Backpack" then
                backpack = child
            end
        end)

        while _G.AutoPunchToggle and globalState.AutoPunch do
            local muscleEvent = getMuscleEvent()
            local character = LocalPlayer.Character

            if character and character:FindFirstChild("Humanoid") then
                local punchInBackpack = LocalPlayer:FindFirstChild("Backpack")
                    and LocalPlayer.Backpack:FindFirstChild("Punch")

                if not character:FindFirstChild("Punch") and punchInBackpack then
                    pcall(function()
                        character.Humanoid:EquipTool(punchInBackpack)
                    end)
                end

                if muscleEvent then
                    pcall(function()
                        muscleEvent:FireServer("punch", punchHand)
                    end)
                end
            end
            task.wait(0.0001)
        end
    end)
end

local function startAntiFly()
    getgenv().AntiFlyActive = true
    disconnectByName("AntiFly")
    connections.AntiFly = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local hitPart, hitPos = workspace:FindPartOnRay(
            Ray.new(hrp.Position, Vector3.new(0, -500, 0)),
            char
        )

        if hitPart then
            local floorY = hitPos.Y
            if hrp.Position.Y - floorY > 0.5 then
                hrp.CFrame = CFrame.new(hrp.Position.X, floorY + 0.5, hrp.Position.Z)
                humanoid.PlatformStand = true
                humanoid.PlatformStand = false
            end
        end
    end)
end

local function setupCharacterReset(char)
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    disconnectByName("ResetDeath")
    if humanoid then
        connections.ResetDeath = humanoid.Died:Connect(function()
            task.wait(0.5)
            disableAllAutoFeatures()
        end)
    end
end

KillingTab:Toggle("Master Killing Toggle", false, "Enables all killing features at once", function(state)
    windowMinimized = state
    disconnectAll()

    if not state then return end

    pcall(function()
        local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
        if rEvents then
            local sizeRemote = rEvents:FindFirstChild("changeSpeedSizeRemote")
            if sizeRemote and sizeRemote.InvokeServer then
                pcall(function()
                    sizeRemote:InvokeServer("changeSize", 0 / 0)
                end)
            end
        end
    end)

    startAutoPunch()
    startAutoProteinEgg()
    startAntiFly()
    startTinyIslandLoop()
    disableAllAutoFeatures()

    if LocalPlayer.Character then
        setupCharacterReset(LocalPlayer.Character)
    end

    disconnectByName("CharacterAddedReset")
    connections.CharacterAddedReset = LocalPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(0.5)
        setupCharacterReset(newChar)
    end)
end)

local autoTargetAttack = false
KillingTab:Toggle("Auto Target Attack", false, "Automatically attack selected target", function(state)
    autoTargetAttack = state
    if not state then return end

    task.spawn(function()
        while autoTargetAttack do
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if char then
                local rightHand = char:FindFirstChild("RightHand")
                local leftHand = char:FindFirstChild("LeftHand")

                if targetMode and rightHand and leftHand then
                    local targetPlayer = Players:FindFirstChild(targetMode)
                    if targetPlayer then
                        local targetChar = targetPlayer.Character
                        local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                        if targetHRP then
                            pcall(function()
                                firetouchinterest(rightHand, targetHRP, 1)
                                firetouchinterest(leftHand, targetHRP, 1)
                                firetouchinterest(rightHand, targetHRP, 0)
                                firetouchinterest(leftHand, targetHRP, 0)
                            end)
                        end
                    end
                end
                task.wait(0.05)
            end
        end
    end)
end)

local viewPlayerEnabled = false
KillingTab:Toggle("View Player", false, "Set camera to view target player", function(state)
    viewPlayerEnabled = state
    local camera = workspace.CurrentCamera

    if state then
        task.spawn(function()
            while viewPlayerEnabled do
                if targetHitbox then
                    local targetPlayer = Players:FindFirstChild(targetHitbox)
                    if targetPlayer and targetPlayer.Character then
                        camera.CameraSubject = targetPlayer.Character
                    end
                end
                task.wait(0.1)
            end

            local char = LocalPlayer.Character
            if char then
                camera.CameraSubject = char:FindFirstChild("Humanoid")
            end
        end)
    else
        if workspace.CurrentCamera then
            local char = LocalPlayer.Character
            workspace.CurrentCamera.CameraSubject = char and char:FindFirstChildOfClass("Humanoid")
        end
    end
end)

local function registerPlayer(player)
    if player ~= LocalPlayer then
        killTargets[player.DisplayName] = player.Name
    end
end

local function unregisterPlayer(player)
    killTargets[player.DisplayName] = nil
end

for _, player in ipairs(Players:GetPlayers()) do
    registerPlayer(player)
end

Players.PlayerAdded:Connect(registerPlayer)
Players.PlayerRemoving:Connect(unregisterPlayer)

local targetLabel = KillingTab:Label("Target: NONE")
local viewLabel = KillingTab:Label("Viewing: NONE")

task.spawn(function()
    while true do
        local targetText = "Target: NONE"
        if targetMode then
            local foundPlayer = Players:FindFirstChild(targetMode)
            if foundPlayer then
                targetText = "Target: " .. foundPlayer.DisplayName
            end
        end
        pcall(function() targetLabel:Set(targetText) end)

        local viewText = "Viewing: NONE"
        if targetHitbox then
            local foundPlayer = Players:FindFirstChild(targetHitbox)
            if foundPlayer then
                viewText = "Viewing: " .. foundPlayer.DisplayName
            end
        end
        pcall(function() viewLabel:Set(viewText) end)

        task.wait(0.2)
    end
end)

-- ============================================
-- PET MANAGEMENT TAB
-- ============================================
local PetsTab = Window:Tab("Pets", "rbxassetid://10723415358")

local petsFolder = LocalPlayer:WaitForChild("petsFolder")
local hatchRemote = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("openEggRemote")
local evolveRemote = ReplicatedStorage.rEvents:WaitForChild("evolvePetEvent")
local tradeRemote = ReplicatedStorage.rEvents:WaitForChild("tradeRemote")
local giftRemote = ReplicatedStorage.rEvents:WaitForChild("giftRemote")

local selectedEgg = nil
local selectedPet = nil
local selectedGiftTarget = nil
local petGiveAmount = 6
local autoHatchEnabled = false
local autoEvolveEnabled = false
local autoGiftEnabled = false
local autoGiftAllEnabled = false
local isHatching = false
local isEvolving = false
local isGifting = false
local isGiftingAll = false

local function autoHatch()
    if isHatching then return end
    isHatching = true
    while autoHatchEnabled do
        if selectedEgg then
            local eggObj = StarterPack:FindFirstChild(selectedEgg)
            if eggObj then
                local success, err = pcall(function()
                    hatchRemote:InvokeServer(eggObj)
                end)
                if not success then
                    warn("Auto Hatch Error: " .. tostring(err))
                end
            end
        end
        task.wait(0.1)
    end
    isHatching = false
end

local function giftPetByName(targetName, amount)
    local petsContainer = LocalPlayer:FindFirstChild("petsFolder")
    if not petsContainer then return end

    local uniqueFolder = petsContainer:FindFirstChild("Unique")
    if not uniqueFolder then return end

    local given = 0
    for _, pet in ipairs(uniqueFolder:GetChildren()) do
        if pet.Name == targetName then
            tradeRemote:FireServer("offerItem", pet)
            task.wait(0.05)
            given = given + 1
            if given >= amount then break end
        end
    end
end

local function autoEvolve()
    if isEvolving then return end
    isEvolving = true
    while autoEvolveEnabled do
        if selectedPet then
            local success, err = pcall(function()
                evolveRemote:FireServer("evolvePet", selectedPet)
            end)
            if not success then
                warn("Auto Evolve Error: " .. tostring(err))
            end
        end
        task.wait(0.1)
    end
    isEvolving = false
end

local function attemptTrade(targetPlayer)
    if not targetPlayer or not selectedPet then return end
    pcall(function()
        tradeRemote:FireServer("sendTradeRequest", targetPlayer)
    end)
    task.wait(0.2)
    giftPetByName(selectedPet, petGiveAmount)
    task.wait(0.1)
    pcall(function()
        tradeRemote:FireServer("acceptTrade")
    end)
end

local function autoGift()
    if isGifting then return end
    isGifting = true
    while autoGiftEnabled do
        if selectedGiftTarget then
            attemptTrade(selectedGiftTarget)
        end
        task.wait(0.5)
    end
    isGifting = false
end

local function autoGiftAll()
    if isGiftingAll then return end
    isGiftingAll = true
    while autoGiftAllEnabled do
        if selectedPet then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    attemptTrade(player)
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end
    isGiftingAll = false
end

PetsTab:Label("Pet Management")

PetsTab:Dropdown("Select Pet", {}, nil, function(value)
    selectedPet = value
end)

local petList = {
    "Common Pet", "Uncommon Pet", "Rare Pet", "Epic Pet", "Legendary Pet",
    "Mythic Pet", "Strong Pet", "Tribal Overlord", "Swift Samurai", "Iron Titan",
    "Power Beast", "Golden Lion", "Crystal Eagle", "Shadow Wolf", "Fire Dragon",
    "Ice Phoenix", "Storm Hawk", "Earth Golem", "Lava Bear", "Dark Knight",
    "Ancient Warrior", "Cosmic Guardian", "Nebula Beast", "Star Hunter",
    "Galaxy Lord", "Universe King", "Black Hole Beast", "Quantum Tiger",
    "Time Walker", "Space Marine", "Void Hunter", "Eternal King",
    "Infinity Beast", "Divine Lord", "Holy Beast", "Sacred Guardian"
}

for _, petName in ipairs(petList) do
    selectedPet = petName
end

PetsTab:Toggle("Auto Hatch", false, "Automatically hatch selected egg", function(state)
    autoHatchEnabled = state
    if state then
        task.spawn(autoHatch)
    end
end)

PetsTab:Toggle("Auto Evolve", false, "Automatically evolve selected pet", function(state)
    autoEvolveEnabled = state
    if state then
        task.spawn(autoEvolve)
    end
end)

PetsTab:Label("Pet Trading")

PetsTab:Dropdown("Select Player", {}, nil, function(playerName)
    local foundPlayer = Players:FindFirstChild(playerName)
    if foundPlayer then
        selectedGiftTarget = foundPlayer
    end
end)

local playerListDropdown = nil

local function addPlayerToList(player)
    if player ~= LocalPlayer then
        if playerListDropdown then
            playerListDropdown:Add(player.Name)
        end
    end
end

local function removePlayerFromList(player)
    if player ~= LocalPlayer then
        pcall(function()
            if playerListDropdown then
                playerListDropdown:Remove(player.Name)
            end
        end)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    addPlayerToList(player)
end

Players.PlayerAdded:Connect(addPlayerToList)
Players.PlayerRemoving:Connect(removePlayerFromList)

PetsTab:Toggle("Auto Gift", false, "Automatically gift to selected player", function(state)
    autoGiftEnabled = state
    if state then
        task.spawn(autoGift)
    end
end)

PetsTab:Toggle("Auto Gift All Players", false, "Gift to every player in server", function(state)
    autoGiftAllEnabled = state
    if state then
        task.spawn(autoGiftAll)
    end
end)

PetsTab:Label("Manual Trade: " .. tostring(petGiveAmount) .. " pets per trade")

PetsTab:Button("Gift Selected Pet", function()
    if selectedPet then
        giftPetByName(selectedPet, petGiveAmount)
    else
        warn("Select a pet first.")
    end
end)

PetsTab:Button("Send Gift to Selected Player", function()
    if not selectedPet then
        warn("Select a pet to give.")
        return
    end
    if not selectedGiftTarget then
        warn("Select a player to give to.")
        return
    end

    local petsContainer = LocalPlayer:FindFirstChild("petsFolder")
    if not petsContainer then
        warn("petsFolder not found.")
        return
    end

    local uniqueFolder = petsContainer:FindFirstChild("Unique")
    if not uniqueFolder then
        warn("Unique pets folder not found.")
        return
    end

    local petToGift = nil
    for _, pet in ipairs(uniqueFolder:GetChildren()) do
        if pet.Name == selectedPet then
            petToGift = pet
            break
        end
    end

    if not petToGift then
        warn("Pet not found in your collection.")
        return
    end

    if giftRemote then
        pcall(function()
            giftRemote:InvokeServer("giftRequest", selectedGiftTarget, petToGift)
        end)
    else
        warn("Gift remote not available.")
    end
end)

-- ============================================
-- LINKS TAB
-- ============================================
local LinksTab = Window:Tab("Links", "rbxassetid://10723434947")

LinksTab:Seperator("Social Links")

LinksTab:Button("Copy YouTube Link", function()
    if setclipboard then
        setclipboard("https://www.youtube.com/@LunoraHub")
    end
end)

LinksTab:Button("Copy Discord Link", function()
    if setclipboard then
        setclipboard("https://discord.gg/e37tPFsAmM")
    end
end)
