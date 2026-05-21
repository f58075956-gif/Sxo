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
local FolderROCK2 = farmTab:AddFolder("ROCK-V2")



local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer

getgenv().RockFarm = false
getgenv().SelectedRock = nil

local muscleEvent = LP:WaitForChild("muscleEvent")

--// TP
local function tp(cf)

    local char = LP.Character

    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cf + Vector3.new(0,3,0)
    end
end

--// GET ROCK
local function getRock(target)

    for _,v in ipairs(workspace.machinesFolder:GetChildren()) do

        local durability = v:FindFirstChild("neededDurability")
        local rock = v:FindFirstChild("Rock")

        if durability and rock then

            if durability.Value == target then
                return rock
            end
        end
    end
end

--// MAIN FARM
task.spawn(function()

    while RunService.Heartbeat:Wait() do

        if getgenv().RockFarm and getgenv().SelectedRock then

            local char = LP.Character

            if char
            and char:FindFirstChild("RightHand")
            and char:FindFirstChild("LeftHand") then

                local right = char.RightHand
                local left = char.LeftHand

                local rock = getRock(getgenv().SelectedRock)

                if rock then

                    tp(rock.Position)

                    -- PUNCH REMOTE
                    for i = 1,10 do
                        muscleEvent:FireServer("punch","rightHand")
                        muscleEvent:FireServer("punch","leftHand")
                    end

                    -- TOUCH
                    for i = 1,50 do

                        firetouchinterest(right, rock, 0)
                        firetouchinterest(right, rock, 1)

                        firetouchinterest(left, rock, 0)
                        firetouchinterest(left, rock, 1)

                    end
                end
            end
        end
    end
end)

--// SWITCHES
FolderROCK2:AddSwitch("Tiny Island Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 0
end)

FolderROCK2:AddSwitch("Starter Island Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 100
end)

FolderROCK2:AddSwitch("Legend Beach Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 5000
end)

FolderROCK2:AddSwitch("Frost Gym Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 150000
end)

FolderROCK2:AddSwitch("Mythical Gym Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 400000
end)

FolderROCK2:AddSwitch("Eternal Gym Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 750000
end)

FolderROCK2:AddSwitch("Legend Gym Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 1000000
end)

FolderROCK2:AddSwitch("Muscle King Gym Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 5000000
end)

FolderROCK2:AddSwitch("Ancient Jungle Rock", function(v)
    getgenv().RockFarm = v
    getgenv().SelectedRock = 10000000
end)
