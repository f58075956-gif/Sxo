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
local Folderanal = farmTab:AddFolder("FARM-ROCK-V1")

getgenv().autoFarm = false

-- 🔥 TOOL + REMOTE MEJORADO
local function gettool()
    local LP = game.Players.LocalPlayer
    local char = LP.Character
    local bp = LP.Backpack

    local tool = char:FindFirstChildOfClass("Tool") or bp:FindFirstChildOfClass("Tool")

    if tool then
        tool.Parent = char

        local attackTime = tool:FindFirstChild("attackTime")
        if attackTime then
            attackTime.Value = 0
        end
    end

    local remote = LP:FindFirstChild("muscleEvent")
    if remote then
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")

        remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "rightHand")

        
	end
end

-- ⚡ FUNCIÓN BASE DE FARM (MEJORADA)
local function farmRock(targetDurability)
    spawn(function()
        while getgenv().autoFarm do
            local LP = game.Players.LocalPlayer
            local char = LP.Character

            if char and char:FindFirstChild("RightHand") and char:FindFirstChild("LeftHand") then
                local right = char.RightHand
                local left = char.LeftHand

                for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == targetDurability then
                        local rock = v.Parent:FindFirstChild("Rock")

                        if rock then
                            -- 💀 MULTI TOUCH (RANGE BOOST)
                            for i = 90000, 100000 do
								firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
									firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
								firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
								firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
								
								
                            end
                            -- 🔥 punch real
                            gettool()
                        end
                    end
                end
            end

           task.wait(0)  -- ⚡ velocidad óptima
        end
    end)
end

-- 🔘 SWITCHES (todos arreglados)
Folderanal:AddSwitch("Tiny Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(0) end
end)

Folderanal:AddSwitch("Starter Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(100) end
end)

Folderanal:AddSwitch("Legend Beach Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(5000) end
end)

Folderanal:AddSwitch("Frost Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(150000) end
end)

Folderanal:AddSwitch("Mythical Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(400000) end
end)

Folderanal:AddSwitch("Eternal Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(750000) end
end)

Folderanal:AddSwitch("Legend Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(1000000) end
end)

Folderanal:AddSwitch("Muscle King Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(5000000) end
end)

Folderanal:AddSwitch("Ancient Jungle Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(10000000) end
end) 
