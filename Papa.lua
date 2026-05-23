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


Create Papa.lua
local farmTab = window:AddTab("Rock")
local FolderROCK2 = farmTab:AddFolder("ROCK-V2")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
getgenv().autoFarm = false
getgenv().autoPunch = false
--// CACHE
local muscleEvent = LP:WaitForChild("muscleEvent")
--// TP
local function tpToRock(rock)
    local char = LP.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = rock.CFrame + Vector3.new(0,3,0)
    end
end
--// FAST PUNCH
task.spawn(function()
    while task.wait() do
        if getgenv().autoPunch then
            for i = 1, 15 do
                muscleEvent:FireServer("punch","rightHand")
                muscleEvent:FireServer("punch","leftHand")
            end
        end
    end
end)
--// GET ROCK
local function getRockByDurability(targetDurability)
    for _, v in ipairs(workspace.machinesFolder:GetDescendants()) do
        if v.Name == "neededDurability"
        and v:IsA("NumberValue")
        and v.Value == targetDurability then
            local rock = v.Parent:FindFirstChild("Rock")
            if rock then
                return rock
            end
        end
    end
end
--// FARM
local function farmRock(targetDurability)
    task.spawn(function()
        getgenv().autoPunch = true
        local rock = getRockByDurability(targetDurability)
        if not rock then
            warn("Rock not found:", targetDurability)
            return
        end
        while getgenv().autoFarm do
            local char = LP.Character
            if char
            and char:FindFirstChild("RightHand")
            and char:FindFirstChild("LeftHand") then
                local right = char.RightHand
                local left = char.LeftHand
                tpToRock(rock)
                for i = 1, 150 do
                    firetouchinterest(rock, right, 0)
                    firetouchinterest(rock, right, 1)
                    firetouchinterest(rock, left, 0)
                    firetouchinterest(rock, left, 1)
                end
            end
            task.wait()
        end
        getgenv().autoPunch = false
    end)
end
--// ROCKS
FolderROCK2:AddSwitch("Tiny Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(0)
    end
end)
FolderROCK2:AddSwitch("Starter Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(100)
    end
end)
FolderROCK2:AddSwitch("Legend Beach Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(5000)
    end
end)
FolderROCK2:AddSwitch("Frost Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(150000)
    end
end)
FolderROCK2:AddSwitch("Mythical Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(400000)
    end
end)
FolderROCK2:AddSwitch("Eternal Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(750000)
    end
end)
FolderROCK2:AddSwitch("Legend Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(1000000)
    end
end)
FolderROCK2:AddSwitch("Muscle King Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(5000000)
    end
end)
FolderROCK2:AddSwitch("Ancient Jungle Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then
        farmRock(10000000)
    end
end)
