local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local muscleEvent = player:WaitForChild("muscleEvent")
local leaderstats = player:WaitForChild("leaderstats") -- Espera infinito hasta que aparezca
local rebirthsStat = leaderstats and leaderstats:FindFirstChild("Rebirths")

-- Si no encuentra leaderstats, el script no debe seguir intentando cargar las stats
if not leaderstats then 
    warn("Error: No se encontró leaderstats. El script se detendrá.")
    return -- Detiene el script aquí
end
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer

local title = ("ZIX")


local library = loadstring(game:HttpGet("https://pastebin.com/raw/wqJ8PvkW", true))()

local window = library:AddWindow(title, {
    main_color = Color3.fromRGB(0, 0, 0),
    min_size = Vector2.new(800, 870),
    can_resize = true,
})
local farmTab = window:AddTab("Rock")
farmTab:AddLabel("Rock Farming OP")

getgenv().autoFarm = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer

-- ⚡ EQUIP TOOL
local function equipTool()
    local char = LP.Character
    local bp = LP.Backpack

    if not char then
        return nil
    end

    local tool = char:FindFirstChildOfClass("Tool")
        or bp:FindFirstChildOfClass("Tool")

    if tool and tool.Parent ~= char then
        tool.Parent = char
    end

    return tool
end

-- 🔥 PUNCH SPAM
local function spamPunch()
    local remote = LP:FindFirstChild("muscleEvent")

    if remote then
        for i = 1, 50 do
            remote:FireServer("punch", "rightHand")
            remote:FireServer("punch", "leftHand")
        end
    end
end

-- 💀 TOUCH BOOST
local function touchRock(rock, right, left)
    for i = 1, 5000 do
        firetouchinterest(right, rock, 0)
        firetouchinterest(right, rock, 1)

        firetouchinterest(left, rock, 0)
        firetouchinterest(left, rock, 1)
    end
end

-- ⚡ MAIN FARM
local function farmRock(targetDurability)
    spawn(function()
        while getgenv().autoFarm do
            local char = LP.Character

            if char
                and char:FindFirstChild("HumanoidRootPart")
                and char:FindFirstChild("RightHand")
                and char:FindFirstChild("LeftHand")
            then
                local hrp = char.HumanoidRootPart
                local right = char.RightHand
                local left = char.LeftHand

                equipTool()

                for _, v in ipairs(workspace.machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability"
                        and tonumber(v.Value) == tonumber(targetDurability)
                    then
                        local rock = v.Parent:FindFirstChild("Rock")

                        if rock and rock:IsA("BasePart") then
                            -- 📍 TP directo al rock
                            hrp.CFrame = rock.CFrame + Vector3.new(0, 3, 0)

                            -- 💀 pegar siempre
                            touchRock(rock, right, left)

                            -- 🔥 spam remoto
                            spamPunch()
                        end
                    end
                end
            end

            RunService.Heartbeat:Wait()
        end
    end)
end

-- 🔘 SWITCHES
farmTab:AddSwitch("Tiny Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(0) end
end)

farmTab:AddSwitch("Starter Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(100) end
end)

farmTab:AddSwitch("Legend Beach Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(5000) end
end)

farmTab:AddSwitch("Frost Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(150000) end
end)

farmTab:AddSwitch("Mythical Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(400000) end
end)

farmTab:AddSwitch("Eternal Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(750000) end
end)

farmTab:AddSwitch("Legend Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(1000000) end
end)

farmTab:AddSwitch("Muscle King Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(5000000) end
end)

farmTab:AddSwitch("Ancient Jungle Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(10000000) end
end)
