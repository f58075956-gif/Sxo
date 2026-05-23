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

getgenv().autoFarm = false
getgenv().autoPunch = false

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 📍 TELEPORT
local function tpToRock(rock)
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if hrp and rock then
        hrp.CFrame = rock.CFrame + Vector3.new(0, 2.5, 0)
    end
end

-- 👊 PUNCH LOOP (estable y rápido)
task.spawn(function()
    local remote = LP:WaitForChild("muscleEvent", 5)

    while task.wait(0) do
        if getgenv().autoPunch and remote then
            remote:FireServer("punch", "rightHand")
            remote:FireServer("punch", "leftHand")
        end
    end
end)

-- 🔍 BUSCAR ROCA
local function getRock(target)
    local folder = workspace:FindFirstChild("machinesFolder")
    if not folder then return nil end

    for _, v in ipairs(folder:GetDescendants()) do
        if v:IsA("NumberValue")
        and v.Name == "neededDurability"
        and v.Value == target then

            local rock = v.Parent and v.Parent:FindFirstChild("Rock")
            if rock then
                return rock
            end
        end
    end

    return nil
end

-- ⚡ FARM LOOP
local function farmRock(target)
    task.spawn(function()
        getgenv().autoPunch = true

        local rock = getRock(target)
        if not rock then
            warn("Rock no encontrada:", target)
            getgenv().autoPunch = false
            return
        end

        while getgenv().autoFarm do
            local char = LP.Character
            local right = char and char:FindFirstChild("RightHand")
            local left = char and char:FindFirstChild("LeftHand")

            if right and left then
                tpToRock(rock)

                -- ⚡ HIT CONTROLADO (estable)
                for i = 1, 300 do
                    firetouchinterest(rock, right, 0)
                    firetouchinterest(rock, right, 1)

                    firetouchinterest(rock, left, 0)
                    firetouchinterest(rock, left, 1)
                end
            end

            task.wait(0)
        end

        getgenv().autoPunch = false
    end)
end

-- 🪨 SWITCHES
FolderROCK2:AddSwitch("Tiny Island Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(0) end
end)

FolderROCK2:AddSwitch("Starter Island Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(100) end
end)

FolderROCK2:AddSwitch("Legend Beach Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(5000) end
end)

FolderROCK2:AddSwitch("Frost Gym Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(150000) end
end)

FolderROCK2:AddSwitch("Mythical Gym Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(400000) end
end)

FolderROCK2:AddSwitch("Eternal Gym Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(750000) end
end)

FolderROCK2:AddSwitch("Legend Gym Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(1000000) end
end)

FolderROCK2:AddSwitch("Muscle King Gym Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(5000000) end
end)

FolderROCK2:AddSwitch("Ancient Jungle Rock", function(v)
    getgenv().autoFarm = v
    if v then farmRock(10000000) end
end)
