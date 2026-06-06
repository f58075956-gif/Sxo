autoToolsProFolder:AddButton("unlock Gamepass AutoLift", function()
    local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
    local player = game:GetService("Players").LocalPlayer
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end
end)

-- FunciÃ³n para crear switches de auto-equip
local function createAutoToolSwitch(toolName, globalVar)
    autoToolsProFolder:AddSwitch("Auto " .. toolName, function(Value)
        _G[globalVar] = Value

        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        if Value then
            local tool = LocalPlayer.Backpack:FindFirstChild(toolName)
            if tool then
                LocalPlayer.Character.Humanoid:EquipTool(tool)
            end
        else
            local character = LocalPlayer.Character
            local equipped = character:FindFirstChild(toolName)
            if equipped then
                equipped.Parent = LocalPlayer.Backpack
            end
        end

        task.spawn(function()
            while _G[globalVar] do
                if not _G[globalVar] then break end
                LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0.1)
            end
        end)
    end)
end

-- Crear los switches principales
createAutoToolSwitch("Weight", "AutoWeightPro")
createAutoToolSwitch("Pushups", "AutoPushupsPro")
createAutoToolSwitch("Handstands", "AutoHandstandsPro")
createAutoToolSwitch("Situps", "AutoSitupsPro")

-- Auto Punch mejorado
autoToolsProFolder:AddSwitch("Auto Punch", function(Value)
    _G.fastHitActivePro = Value
    local LocalPlayer = game:GetService("Players").LocalPlayer

    if Value then
        task.spawn(function()
            while _G.fastHitActivePro do
                if not _G.fastHitActivePro then break end

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
            while _G.fastHitActivePro do
                if not _G.fastHitActivePro then break end
                LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                LocalPlayer.muscleEvent:FireServer("punch", "leftHand")

                local character = LocalPlayer.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                task.wait()
            end
        end)
    else
        local character = LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = LocalPlayer.Backpack
        end
    end
end)

-- Fast Tools mejorado
autoToolsProFolder:AddSwitch("Fast Tools", function(Value)
    _G.FastToolsPro = Value
    local LocalPlayer = game:GetService("Players").LocalPlayer

    local toolSettings = {
        {"Punch", "attackTime", Value and 0 or 0.35},
        {"Ground Slam", "attackTime", Value and 0 or 6},
        {"Stomp", "attackTime", Value and 0 or 7},
        {"Handstands", "repTime", Value and 0 or 1},
        {"Pushups", "repTime", Value and 0 or 1},
        {"Weight", "repTime", Value and 0 or 1},
        {"Situps", "repTime", Value and 0 or 1}
    }

    local backpack = LocalPlayer:WaitForChild("Backpack")

    for _, toolInfo in ipairs(toolSettings) do
        local tool = backpack:FindFirstChild(toolInfo[1])
        if tool and tool:FindFirstChild(toolInfo[2]) then
            tool[toolInfo[2]].Value = toolInfo[3]
        end

        local equippedTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(toolInfo[1])
        if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
            equippedTool[toolInfo[2]].Value = toolInfo[3]
        end
    end
end)
