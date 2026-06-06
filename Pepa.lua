local SelectedTool = nil
local AutoFarmActive = false
local selectedRock = nil
autoToolsFolder:AddLabel("Select the tool you will use:").TextSize = 22

local toolDropdown = autoToolsFolder:AddDropdown("Select Tool", function(selection)
    SelectedTool = selection
end)
toolDropdown:Add("Weight")
toolDropdown:Add("Pushups")
toolDropdown:Add("Situps")
toolDropdown:Add("Handstands")
toolDropdown:Add("Fast Punch")
toolDropdown:Add("Stomp")
toolDropdown:Add("Ground Slam")


local rockData = {
    ["Jungle Rock"] = 10000000
}

local rockDropdown = autoToolsFolder:AddDropdown("Select Rock", function(selection)
    selectedRock = selection
end)
for rockName in pairs(rockData) do
    rockDropdown:Add(rockName)
end

local function punchTool()
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == "Punch" and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(v)
        end
    end
    player.muscleEvent:FireServer("punch", "leftHand")
    player.muscleEvent:FireServer("punch", "rightHand")
end

local function startFarming()
    task.spawn(function()
        while AutoFarmActive do
            local char = player.Character or player.CharacterAdded:Wait()
            local toolName = SelectedTool
            local durability = player.Durability and player.Durability.Value or 0

            if toolName == "Weight" or toolName == "Pushups" or toolName == "Situps" or toolName == "Handstands" then
                if not char:FindFirstChild(toolName) then
                    local tool = player.Backpack:FindFirstChild(toolName)
                    if tool then
                        pcall(function() char.Humanoid:EquipTool(tool) end)
                    end
                end
                pcall(function() player.muscleEvent:FireServer("rep") end)
            elseif toolName == "Fast Punch" then
                punchTool()
            elseif toolName == "Stomp" then
                local stomp = player.Backpack:FindFirstChild("Stomp")
                if stomp and not char:FindFirstChild("Stomp") then
                    pcall(function() stomp.Parent = char end)
                    if stomp:FindFirstChild("attackTime") then
                        pcall(function() stomp.attackTime.Value = 0 end)
                    end
                end
                pcall(function() player.muscleEvent:FireServer("stomp") end)
                if char:FindFirstChild("Stomp") then
                    pcall(function() char.Stomp:Activate() end)
                end
                if tick() % 6 < 0.1 then
                    local vu = game:GetService("VirtualUser")
                    pcall(function()
                        vu:CaptureController()
                        vu:ClickButton1(Vector2.new(500, 500))
                    end)
                end
            elseif toolName == "Ground Slam" then
                local gs = player.Backpack:FindFirstChild("Ground Slam")
                if gs and not char:FindFirstChild("Ground Slam") then
                    pcall(function() gs.Parent = char end)
                    if gs:FindFirstChild("attackTime") then
                        pcall(function() gs.attackTime.Value = 0 end)
                    end
                end
                pcall(function() player.muscleEvent:FireServer("slam") end)
                if char:FindFirstChild("Ground Slam") then
                    pcall(function() char["Ground Slam"]:Activate() end)
                end
                if tick() % 6 < 0.1 then
                    local vu = game:GetService("VirtualUser")
                    pcall(function()
                        vu:CaptureController()
                        vu:ClickButton1(Vector2.new(500, 500))
                    end)
                end
            end

            if selectedRock then
                local requiredDurability = rockData[selectedRock]
                if durability >= requiredDurability then
                    for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == requiredDurability and
                           char:FindFirstChild("LeftHand") and char:FindFirstChild("RightHand") then
                            local rock = v.Parent:FindFirstChild("Rock")
                            if rock then
                                pcall(function()
                                    firetouchinterest(rock, char.RightHand, 0)
                                    firetouchinterest(rock, char.RightHand, 1)
                                    firetouchinterest(rock, char.LeftHand, 0)
                                    firetouchinterest(rock, char.LeftHand, 1)
                                end)
                                punchTool()
                            end
                        end
                    end
                end
            end
            task.wait()
        end
    end)
end

autoToolsFolder:AddSwitch("Start", function(enabled)
    AutoFarmActive = enabled
    if enabled then
        startFarming()
    else
        if SelectedTool and player.Character and player.Character:FindFirstChild(SelectedTool) then
            pcall(function()
                player.Character:FindFirstChild(SelectedTool).Parent = player.Backpack
            end)
        end
    end
end)
