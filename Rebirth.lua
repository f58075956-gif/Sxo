-- Script Path: game:GetService("ReplicatedStorage").globalFunctions
-- Took 0.17s to decompile.
-- Executor: Delta (1.1.721.1108)

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = v_u_1:WaitForChild("rebirthGemsIncrement")
local v_u_3 = v_u_1:WaitForChild("baseRebirthStrength")
local v_u_4 = v_u_1:WaitForChild("rebirthStrengthIncrement")
local function v_u_12(p5, p6, p7) -- name: addQuestProgress
    local v8 = p5:FindFirstChild("requirements", true)
    if v8 ~= nil then
        for _, v9 in pairs(v8:GetChildren()) do
            if v9 ~= nil and (string.lower(v9.Name) == string.lower(p6) and (v9:IsA("IntValue") or v9:IsA("NumberValue"))) then
                local v10 = v9:FindFirstChild("progress")
                if v10 ~= nil and v10.Value < v9.Value then
                    local v11 = v10.Value + p7
                    if v9.Value <= v11 then
                        v11 = v9.Value
                    end
                    v10.Value = v11
                end
            end
        end
    end
end
local function v_u_23(p13, p14, p15) -- name: checkToAddQuestProgress
    -- upvalues: (copy) v_u_12
    local v16 = p13:FindFirstChild("Quests")
    if v16 ~= nil then
        local v17 = v16:FindFirstChild("Story Quests")
        local v18 = v16:FindFirstChild("Daily Quests")
        local v19 = v16:FindFirstChild("Weekly Quests")
        if v17 ~= nil and (v18 ~= nil and v19 ~= nil) then
            for _, v20 in pairs(v17:GetChildren()) do
                if v20 ~= nil then
                    v_u_12(v20, p14, p15)
                end
            end
            for _, v21 in pairs(v18:GetChildren()) do
                if v21 ~= nil then
                    v_u_12(v21, p14, p15)
                end
            end
            for _, v22 in pairs(v19:GetChildren()) do
                if v22 ~= nil then
                    v_u_12(v22, p14, p15)
                end
            end
        end
    end
end
local v_u_24 = v_u_1:WaitForChild("rebirthMultiplierIncrement")
local function v_u_28(p25, p26) -- name: calculatePerksToAdd
    if p25 == nil or p26 == nil then
        return 0
    end
    local v27 = 0
    if p25 == "strength" then
        v27 = v27 + 1
        if p26 == "Basic" then
            return v27
        end
        if p26 == "Advanced" then
            return v27 + 1
        end
        if p26 == "Rare" then
            return v27 + 2
        end
        if p26 == "Epic" then
            return v27 + 3
        end
        if p26 == "Unique" then
            return v27 + 4
        end
    elseif p25 == "durability" then
        v27 = v27 + 1
        if p26 == "Basic" then
            return v27
        end
        if p26 == "Advanced" then
            return v27 + 1
        end
        if p26 == "Rare" then
            return v27 + 2
        end
        if p26 == "Epic" then
            return v27 + 3
        end
        if p26 == "Unique" then
            return v27 + 4
        end
    elseif p25 == "agility" then
        v27 = v27 + 1
        if p26 == "Basic" then
            return v27
        end
        if p26 == "Advanced" then
            return v27 + 1
        end
        if p26 == "Rare" then
            return v27 + 2
        end
        if p26 == "Epic" then
            return v27 + 3
        end
        if p26 == "Unique" then
            return v27 + 4
        end
    elseif p25 == "damage" then
        v27 = v27 + 1
        if p26 == "Basic" then
            return v27
        end
        if p26 == "Advanced" then
            return v27 + 1
        end
        if p26 == "Rare" then
            return v27 + 2
        end
        if p26 == "Epic" then
            return v27 + 3
        end
        if p26 == "Unique" then
            return v27 + 4
        end
    elseif p25 == "gems" then
        v27 = v27 + 1
        if p26 == "Basic" then
            return v27
        end
        if p26 == "Advanced" then
            return v27 + 1
        end
        if p26 == "Rare" then
            return v27 + 2
        end
        if p26 == "Epic" then
            return v27 + 3
        end
        if p26 == "Unique" then
            v27 = v27 + 4
        end
    end
    return v27
end
local function v_u_32(p29, p30) -- name: calculatePetPerksToAdd
    if p29 == nil or p30 == nil then
        return 0
    end
    local v31 = 0
    if p29 == "strength" then
        v31 = v31 + 1
        if p30 == "Basic" then
            return v31
        end
        if p30 == "Advanced" then
            return v31 + 1
        end
        if p30 == "Rare" then
            return v31 + 2
        end
        if p30 == "Epic" then
            return v31 + 3
        end
        if p30 == "Unique" then
            return v31 + 4
        end
    elseif p29 == "durability" then
        v31 = v31 + 1
        if p30 == "Basic" then
            return v31
        end
        if p30 == "Advanced" then
            return v31 + 1
        end
        if p30 == "Rare" then
            return v31 + 2
        end
        if p30 == "Epic" then
            return v31 + 3
        end
        if p30 == "Unique" then
            return v31 + 4
        end
    elseif p29 == "agility" then
        v31 = v31 + 1
        if p30 == "Basic" then
            return v31
        end
        if p30 == "Advanced" then
            return v31 + 1
        end
        if p30 == "Rare" then
            return v31 + 2
        end
        if p30 == "Epic" then
            return v31 + 3
        end
        if p30 == "Unique" then
            return v31 + 4
        end
    elseif p29 == "damage" then
        v31 = v31 + 1
        if p30 == "Basic" then
            return v31
        end
        if p30 == "Advanced" then
            return v31 + 1
        end
        if p30 == "Rare" then
            return v31 + 2
        end
        if p30 == "Epic" then
            return v31 + 3
        end
        if p30 == "Unique" then
            return v31 + 4
        end
    elseif p29 == "gems" then
        v31 = v31 + 1
        if p30 == "Basic" then
            return v31
        end
        if p30 == "Advanced" then
            return v31 + 1
        end
        if p30 == "Rare" then
            return v31 + 2
        end
        if p30 == "Epic" then
            return v31 + 3
        end
        if p30 == "Unique" then
            v31 = v31 + 4
        end
    end
    return v31
end
local function v_u_37(p33, p34, p35) -- name: upgradePowerUpPerksFromLevelUp
    -- upvalues: (copy) v_u_28
    if p33 ~= nil and (p34 ~= nil and p35 ~= nil) then
        for _, v36 in pairs(p33:GetChildren()) do
            if v36 ~= nil and v36:IsA("IntValue") then
                v36.Value = v36.Value + p34 * v_u_28(v36.Name, p35)
            end
        end
    end
end
local function v_u_42(p38, p39, p40) -- name: upgradePetPerksFromLevelUp
    -- upvalues: (copy) v_u_32
    if p38 ~= nil and (p39 ~= nil and p40 ~= nil) then
        for _, v41 in pairs(p38:GetChildren()) do
            if v41 ~= nil and v41:IsA("IntValue") then
                v41.Value = v41.Value + p39 * v_u_32(v41.Name, p40)
            end
        end
    end
end
local function v_u_77(p43) -- name: shortenNumberFunc
    if p43 ~= nil then
        local v44 = math.floor(p43)
        local v45 = tostring(v44)
        local v46 = string.len(v45)
        if v46 == 4 then
            local v47 = p43 / 1000
            local v48 = tostring(v47)
            return string.sub(v48, 1, 4) .. "K"
        end
        if v46 == 5 then
            local v49 = p43 / 1000
            local v50 = tostring(v49)
            return string.sub(v50, 1, 4) .. "K"
        end
        if v46 == 6 then
            local v51 = p43 / 1000
            local v52 = tostring(v51)
            return string.sub(v52, 1, 5) .. "K"
        end
        if v46 == 7 then
            local v53 = p43 / 1000000
            local v54 = tostring(v53)
            return string.sub(v54, 1, 4) .. "M"
        end
        if v46 == 8 then
            local v55 = p43 / 1000000
            local v56 = tostring(v55)
            return string.sub(v56, 1, 4) .. "M"
        end
        if v46 == 9 then
            local v57 = p43 / 1000000
            local v58 = tostring(v57)
            return string.sub(v58, 1, 5) .. "M"
        end
        if v46 == 10 then
            local v59 = p43 / 1000000000
            local v60 = tostring(v59)
            return string.sub(v60, 1, 4) .. "B"
        end
        if v46 == 11 then
            local v61 = p43 / 1000000000
            local v62 = tostring(v61)
            return string.sub(v62, 1, 4) .. "B"
        end
        if v46 == 12 then
            local v63 = p43 / 1000000000
            local v64 = tostring(v63)
            return string.sub(v64, 1, 5) .. "B"
        end
        if v46 == 13 then
            local v65 = p43 / 1000000000000
            local v66 = tostring(v65)
            return string.sub(v66, 1, 4) .. "T"
        end
        if v46 == 14 then
            local v67 = p43 / 1000000000000
            local v68 = tostring(v67)
            return string.sub(v68, 1, 4) .. "T"
        end
        if v46 == 15 then
            local v69 = p43 / 1000000000000
            local v70 = tostring(v69)
            return string.sub(v70, 1, 5) .. "T"
        end
        if v46 == 16 then
            local v71 = p43 / 1000000000000000
            local v72 = tostring(v71)
            return string.sub(v72, 1, 4) .. "Qa"
        end
        if v46 ~= 17 then
            if v46 >= 18 then
                local v73 = p43 / 1000000000000000
                local v74 = tostring(v73)
                v45 = string.sub(v74, 1, 5) .. "Qa"
            end
            return v45
        end
        local v75 = p43 / 1000000000000000
        local v76 = tostring(v75)
        return string.sub(v76, 1, 4) .. "Qa"
    end
end
local function v_u_101(p78, p79, p80) -- name: timeFormat
    if p78 <= 0 then
        return "00:00:00"
    elseif p79 == true then
        local v81 = string.format
        local v82 = p78 / 86400
        local v83 = v81("%02.f", (math.floor(v82)))
        local v84 = string.format
        local v85 = p78 / 3600 - v83 * 24
        local v86 = v84("%02.f", (math.floor(v85)))
        local v87 = string.format
        local v88 = p78 / 60 - v86 * 60 - v83 * 24 * 60
        local v89 = v87("%02.f", (math.floor(v88)))
        local v90 = string.format
        local v91 = p78 - v89 * 60 - v86 * 3600 - v83 * 24 * 3600
        return v83 .. "d " .. v86 .. "h " .. v89 .. "m " .. v90("%02.f", (math.floor(v91))) .. "s"
    else
        local v92 = string.format
        local v93 = p78 / 3600
        local v94 = v92("%02.f", (math.floor(v93)))
        local v95 = string.format
        local v96 = p78 / 60 - v94 * 60
        local v97 = v95("%02.f", (math.floor(v96)))
        local v98 = string.format
        local v99 = p78 - v94 * 3600 - v97 * 60
        local v100 = v98("%02.f", (math.floor(v99)))
        if p80 == true then
            return v97 .. ":" .. v100
        else
            return v94 .. ":" .. v97 .. ":" .. v100
        end
    end
end
local function v_u_106(p102, p103) -- name: balanceRequirements
    if p102 ~= nil and p103 ~= nil then
        for _, v104 in pairs(p103:GetChildren()) do
            if v104 ~= nil and (v104:IsA("IntValue") or v104:IsA("NumberValue")) then
                local v105 = v104:Clone()
                v105.Value = 0
                v105.Name = "progress"
                v105.Parent = v104
                if v104.Name == "Pet Hatches" then
                    v104.Name = "Pets Hatched"
                end
            end
        end
    end
end
local function v_u_110(p107, p108) -- name: balanceRewards
    if p107 ~= nil and p108 ~= nil then
        for _, v109 in pairs(p108:GetChildren()) do
            if v109 ~= nil and not v109:IsA("IntValue") then
                v109:IsA("NumberValue")
            end
        end
    end
end
local function v_u_118(p111) -- name: getOrderedQuestTimeline
    local v112 = {}
    for _, v113 in pairs(p111:GetChildren()) do
        if v113 ~= nil then
            local v114 = v113.Name
            local v115 = tonumber(v114)
            table.insert(v112, 1, v115)
        end
    end
    table.sort(v112, function(p116, p117)
        return p116 < p117
    end)
    return v112
end
return {
    ["checkToAddQuestProgress"] = v_u_23,
    ["createCompletedQuestValues"] = function(p119, p120, p121) -- name: createCompletedQuestValues
        if p119 ~= nil then
            local v122 = p119:FindFirstChild("Quests")
            if v122 ~= nil then
                local v123 = v122:FindFirstChild("completedQuests")
                if v123 ~= nil then
                    if p121 ~= nil then
                        local v124 = v123:FindFirstChild(p121)
                        if v124 == nil then
                            local v125 = Instance.new("Folder")
                            v125.Name = p121
                            local v126 = Instance.new("BoolValue")
                            v126.Name = p120
                            v126.Parent = v125
                            v125.Parent = v123
                        else
                            local v127 = Instance.new("BoolValue")
                            v127.Name = p120
                            v127.Parent = v124
                        end
                    end
                    local v128 = Instance.new("BoolValue")
                    v128.Name = p120
                    v128.Parent = v123
                end
            end
        end
    end,
    ["getNextQuestInOrder"] = function(p129, p130) -- name: getNextQuestInOrder
        -- upvalues: (copy) v_u_118
        local v131 = nil
        local v132 = false
        local v133 = false
        if p129 ~= nil and p130 ~= nil then
            local v134 = p129:FindFirstChild("Quests")
            local v135 = p130:FindFirstChild("Quests")
            if v134 ~= nil and v135 ~= nil then
                local v136 = v134:FindFirstChild("Story Quests")
                local v137 = v134:FindFirstChild("completedQuests")
                if v136 ~= nil and v137 ~= nil then
                    local v138 = v136:FindFirstChild(p130.Name)
                    if v138 == nil then
                        local v139 = v137:FindFirstChild(p130.Name)
                        if v139 == nil then
                            return v135:FindFirstChild("1"), v132, v133
                        end
                        local v140 = v_u_118(v135)
                        for _, v141 in pairs(v140) do
                            if v141 ~= nil and v139:FindFirstChild((tostring(v141))) == nil then
                                v131 = v135:FindFirstChild((tostring(v141)))
                                break
                            end
                        end
                        if v131 == nil then
                            local v142 = #v140
                            return v135:FindFirstChild((tostring(v142))), true, v133
                        end
                    else
                        v133 = true
                        for _, v143 in pairs(v138:GetChildren()) do
                            local v144 = v135:FindFirstChild(v143.Name)
                            if v144 ~= nil then
                                return v144, v132, v133
                            end
                            break
                        end
                    end
                end
            end
        end
        return v131, v132, v133
    end,
    ["checkForCompleteQuest"] = function(p145) -- name: checkForCompleteQuest
        local v146 = p145:FindFirstChild("requirements")
        local v147
        if v146 == nil then
            v147 = false
        else
            for _, v148 in pairs(v146:GetChildren()) do
                if v148 ~= nil and (v148:IsA("IntValue") or v148:IsA("NumberValue")) then
                    local v149 = v148:FindFirstChild("progress")
                    if v149 ~= nil and v149.Value < v148.Value then
                        return false
                    end
                end
            end
            v147 = true
        end
        return v147
    end,
    ["createNewPlayerQuest"] = function(p150, p151, p152, p153, p154, p155, _) -- name: createNewPlayerQuest
        -- upvalues: (copy) v_u_106, (copy) v_u_110
        if p150 ~= nil and (p151 ~= nil and (p151.Parent ~= nil and p151.Parent.Parent ~= nil)) then
            local v156 = p150:FindFirstChild("Quests")
            local v157 = p151:FindFirstChild("requirements")
            local v158 = p151:FindFirstChild("rewards")
            if v156 ~= nil and (v157 ~= nil and v158 ~= nil) then
                local v159
                if p153 == true then
                    v159 = v156:FindFirstChild(p151.Parent.Parent.Parent.Name)
                else
                    v159 = v156:FindFirstChild(p151.Parent.Parent.Name)
                end
                if v159 ~= nil then
                    local v160 = Instance.new("Folder")
                    v160.Name = p151.Name
                    local v161 = v157:Clone()
                    if p154 == true then
                        if p155 == nil then
                            v_u_106(p150, v161)
                        else
                            for v162, v163 in pairs(p155) do
                                if v162 ~= nil and v163 ~= nil then
                                    local v164 = v163.requirementAmount
                                    local v165 = v163.progress
                                    if v162 ~= nil then
                                        local v166 = v161:FindFirstChild(v162 == "Pet Hatches" and "Pets Hatched" or v162)
                                        if v166 ~= nil then
                                            v166.Value = v164
                                            if v165 ~= nil then
                                                local v167 = v166:Clone()
                                                v167.Value = v165
                                                v167.Name = "progress"
                                                v167.Parent = v166
                                            end
                                            if v166.Name == "Pet Hatches" then
                                                v166.Name = "Pets Hatched"
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        v_u_106(p150, v161)
                    end
                    v161.Parent = v160
                    local v168 = v158:Clone()
                    v_u_110(p150, v168)
                    v168.Parent = v160
                    local v169 = Instance.new("ObjectValue")
                    v169.Name = "originalQuest"
                    v169.Value = p151
                    v169.Parent = v160
                    if p152 ~= nil then
                        local v170 = Instance.new("StringValue")
                        v170.Name = "whichDay"
                        v170.Value = p152
                        v170.Parent = v160
                    end
                    if p153 == true then
                        local v171 = Instance.new("Folder")
                        v171.Name = p151.Parent.Parent.Name
                        v160.Parent = v171
                        v171.Parent = v159
                        return
                    end
                    v160.Parent = v159
                end
            end
        end
    end,
    ["formatTime"] = function(p172, p173, p174) -- name: formatTime
        -- upvalues: (copy) v_u_101
        return v_u_101(p172, p173, p174)
    end,
    ["decoratePetPerks"] = function(p175, p176, p177, p178) -- name: decoratePetPerks
        -- upvalues: (copy) v_u_1, (copy) v_u_77
        for _, v179 in pairs(p176:GetChildren()) do
            if v179:IsA("ImageLabel") then
                v179:Destroy()
            end
        end
        if p175 ~= nil then
            for _, v180 in pairs(p175:GetChildren()) do
                if v180 ~= nil and (v180:IsA("IntValue") or v180:IsA("NumberValue")) then
                    local v181 = nil
                    for _, v182 in pairs(v_u_1:WaitForChild("priceTypes"):GetChildren()) do
                        if v182 ~= nil and string.lower(v182.Name) == string.lower(v180.Name) then
                            v181 = v182
                            break
                        end
                    end
                    if v181 ~= nil then
                        local v183 = v_u_1:WaitForChild("perkImage"):Clone()
                        if p177 ~= nil then
                            v183.ZIndex = v183.ZIndex + p177
                            for _, v184 in pairs(v183:GetDescendants()) do
                                if v184 ~= nil and v184:IsA("GuiBase") then
                                    v184.ZIndex = v184.ZIndex + p177
                                end
                            end
                        end
                        v183.Image = v181:WaitForChild("image").Image
                        local v185 = p178 == nil and 1 or p178
                        v183:WaitForChild("perkLabel").Text = "+" .. v_u_77(v180.Value * v185) .. " " .. v181.Name
                        v183.perkLabel:WaitForChild("shadow").Text = v183.perkLabel.Text
                        v183.perkLabel.TextColor3 = v181.Value
                        v183.ImageColor3 = v181:WaitForChild("image").ImageColor3
                        v183.Parent = p176
                    end
                end
            end
        end
    end,
    ["calculateMaxFreeSpinsAmount"] = function(p186) -- name: calculateMaxFreeSpinsAmount
        local v187 = p186.MembershipType == Enum.MembershipType.Premium and 3 or 1
        local v188 = p186:FindFirstChild("petsFolder")
        if v188 ~= nil then
            local v189 = v188:FindFirstChild("Unique")
            if v189 ~= nil then
                for _, v190 in pairs(v189:GetChildren()) do
                    if v190 ~= nil and v190.Name == "Sarge" then
                        v187 = v187 + 1
                    end
                end
            end
        end
        local v191 = p186:FindFirstChild("playerJoinedGroup")
        if v191 ~= nil and v191.Value == true then
            v187 = v187 + 1
        end
        local v192 = p186:FindFirstChild("ultimatesFolder")
        if v192 ~= nil then
            local v193 = v192:FindFirstChild("+1 Daily Spin")
            if v193 ~= nil then
                v187 = v187 + v193.Value
            end
        end
        return v187
    end,
    ["defaultTreadmillTime"] = 3,
    ["defaultMachineDistance"] = 20,
    ["getPlayerRank"] = function(p194, p195, p196) -- name: getPlayerRank
        if p194 ~= nil then
            local v197 = nil
            local v198 = Color3.fromRGB(109, 109, 109)
            if p194.Value < 100 then
                local v199 = "Rookie"
                local v200 = Color3.fromRGB(109, 109, 109)
                if p195 == nil or p196 == nil then
                    return v199, v200
                end
                p195.Text = "Rookie"
                p195.TextColor3 = Color3.fromRGB(109, 109, 109)
                p196.ImageColor3 = Color3.fromRGB(109, 109, 109)
                return v199, v200
            end
            if p194.Value >= 100 and p194.Value < 500 then
                local v201 = "Lifter"
                local v202 = Color3.fromRGB(0, 139, 0)
                if p195 == nil or p196 == nil then
                    return v201, v202
                end
                p195.Text = "Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 139, 0)
                p196.ImageColor3 = Color3.fromRGB(0, 139, 0)
                return v201, v202
            end
            if p194.Value >= 500 and p194.Value < 1500 then
                local v203 = "Huge"
                local v204 = Color3.fromRGB(143, 95, 0)
                if p195 == nil or p196 == nil then
                    return v203, v204
                end
                p195.Text = "Huge"
                p195.TextColor3 = Color3.fromRGB(143, 95, 0)
                p196.ImageColor3 = Color3.fromRGB(143, 95, 0)
                return v203, v204
            end
            if p194.Value >= 1500 and p194.Value < 3000 then
                local v205 = "Tank"
                local v206 = Color3.fromRGB(49, 98, 147)
                if p195 == nil or p196 == nil then
                    return v205, v206
                end
                p195.Text = "Tank"
                p195.TextColor3 = Color3.fromRGB(49, 98, 147)
                p196.ImageColor3 = Color3.fromRGB(49, 98, 147)
                return v205, v206
            end
            if p194.Value >= 3000 and p194.Value < 5000 then
                local v207 = "Beast"
                local v208 = Color3.fromRGB(127, 0, 0)
                if p195 == nil or p196 == nil then
                    return v207, v208
                end
                p195.Text = "Beast"
                p195.TextColor3 = Color3.fromRGB(127, 0, 0)
                p196.ImageColor3 = Color3.fromRGB(127, 0, 0)
                return v207, v208
            end
            if p194.Value >= 5000 and p194.Value < 8000 then
                local v209 = "Gigantic"
                local v210 = Color3.fromRGB(85, 255, 0)
                if p195 == nil or p196 == nil then
                    return v209, v210
                end
                p195.Text = "Gigantic"
                p195.TextColor3 = Color3.fromRGB(85, 255, 0)
                p196.ImageColor3 = Color3.fromRGB(85, 255, 0)
                return v209, v210
            end
            if p194.Value >= 8000 and p194.Value < 12000 then
                local v211 = "Monster"
                local v212 = Color3.fromRGB(255, 170, 0)
                if p195 == nil or p196 == nil then
                    return v211, v212
                end
                p195.Text = "Monster"
                p195.TextColor3 = Color3.fromRGB(255, 170, 0)
                p196.ImageColor3 = Color3.fromRGB(255, 170, 0)
                return v211, v212
            end
            if p194.Value >= 12000 and p194.Value < 18000 then
                local v213 = "Colossal"
                local v214 = Color3.fromRGB(170, 85, 255)
                if p195 == nil or p196 == nil then
                    return v213, v214
                end
                p195.Text = "Colossal"
                p195.TextColor3 = Color3.fromRGB(170, 85, 255)
                p196.ImageColor3 = Color3.fromRGB(170, 85, 255)
                return v213, v214
            end
            if p194.Value >= 18000 and p194.Value < 25000 then
                local v215 = "Master Lifter"
                local v216 = Color3.fromRGB(109, 109, 109)
                if p195 == nil or p196 == nil then
                    return v215, v216
                end
                p195.Text = "Master Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 170, 255)
                p196.ImageColor3 = Color3.fromRGB(0, 170, 255)
                return v215, v216
            end
            if p194.Value >= 25000 and p194.Value < 100000 then
                local v217 = "Muscle Legend"
                local v218 = Color3.fromRGB(255, 238, 48)
                if p195 == nil or p196 == nil then
                    return v217, v218
                end
                p195.Text = "Muscle Legend"
                p195.TextColor3 = Color3.fromRGB(255, 238, 48)
                p196.ImageColor3 = Color3.fromRGB(255, 238, 48)
                return v217, v218
            end
            if p194.Value >= 100000 and p194.Value < 10000000 then
                local v219 = "House Lifter"
                local v220 = Color3.fromRGB(85, 255, 0)
                if p195 == nil or p196 == nil then
                    return v219, v220
                end
                p195.Text = "House Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(85, 255, 0)
                p196.ImageColor3 = Color3.fromRGB(85, 255, 0)
                return v219, v220
            end
            if p194.Value >= 10000000 and p194.Value < 50000000 then
                local v221 = "Island Lifter"
                local v222 = Color3.fromRGB(255, 170, 0)
                if p195 == nil or p196 == nil then
                    return v221, v222
                end
                p195.Text = "Island Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(255, 170, 0)
                p196.ImageColor3 = Color3.fromRGB(255, 170, 0)
                return v221, v222
            end
            if p194.Value >= 50000000 and p194.Value < 100000000 then
                local v223 = "Planet Lifter"
                local v224 = Color3.fromRGB(0, 170, 255)
                if p195 == nil or p196 == nil then
                    return v223, v224
                end
                p195.Text = "Planet Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(0, 170, 255)
                p196.ImageColor3 = Color3.fromRGB(0, 170, 255)
                return v223, v224
            end
            if p194.Value >= 100000000 and p194.Value < 250000000 then
                local v225 = "Galaxy Lifter"
                local v226 = Color3.fromRGB(170, 85, 255)
                if p195 == nil or p196 == nil then
                    return v225, v226
                end
                p195.Text = "Galaxy Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(170, 85, 255)
                p196.ImageColor3 = Color3.fromRGB(170, 85, 255)
                return v225, v226
            end
            if p194.Value >= 250000000 and p194.Value < 1000000000 then
                local v227 = "Universe Lifter"
                local v228 = Color3.fromRGB(170, 0, 0)
                if p195 == nil or p196 == nil then
                    return v227, v228
                end
                p195.Text = "Universe Lifter"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(170, 0, 0)
                p196.ImageColor3 = Color3.fromRGB(170, 0, 0)
                return v227, v228
            end
            if p194.Value >= 1000000000 and p194.Value < 5000000000 then
                local v229 = "Multiverse Elite"
                local v230 = Color3.fromRGB(255, 255, 0)
                if p195 == nil or p196 == nil then
                    return v229, v230
                end
                p195.Text = "Multiverse Elite"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(255, 255, 0)
                p196.ImageColor3 = Color3.fromRGB(255, 255, 0)
                return v229, v230
            end
            if p194.Value >= 5000000000 and p194.Value < 15000000000 then
                local v231 = "Gym Sensei"
                local v232 = Color3.fromRGB(85, 255, 0)
                if p195 == nil or p196 == nil then
                    return v231, v232
                end
                p195.Text = "Gym Sensei"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(85, 255, 0)
                p196.ImageColor3 = Color3.fromRGB(85, 255, 0)
                return v231, v232
            end
            if p194.Value >= 15000000000 and p194.Value < 40000000000 then
                local v233 = "Weight King"
                local v234 = Color3.fromRGB(255, 170, 0)
                if p195 == nil or p196 == nil then
                    return v233, v234
                end
                p195.Text = "Weight King"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(255, 170, 0)
                p196.ImageColor3 = Color3.fromRGB(255, 170, 0)
                return v233, v234
            end
            if p194.Value >= 40000000000 and p194.Value < 100000000000 then
                local v235 = "Furious Force"
                local v236 = Color3.fromRGB(0, 170, 255)
                if p195 == nil or p196 == nil then
                    return v235, v236
                end
                p195.Text = "Furious Force"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(0, 170, 255)
                p196.ImageColor3 = Color3.fromRGB(0, 170, 255)
                return v235, v236
            end
            if p194.Value >= 100000000000 and p194.Value < 250000000000 then
                local v237 = "ULTRA Titan"
                local v238 = Color3.fromRGB(170, 85, 255)
                if p195 == nil or p196 == nil then
                    return v237, v238
                end
                p195.Text = "ULTRA Titan"
                p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                p195.TextStrokeColor3 = Color3.fromRGB(170, 85, 255)
                p196.ImageColor3 = Color3.fromRGB(170, 85, 255)
                return v237, v238
            end
            if p194.Value < 250000000000 or p194.Value >= 500000000000 then
                if p194.Value >= 500000000000 then
                    v197 = "SUPREME Power"
                    v198 = Color3.fromRGB(255, 255, 0)
                    if p195 == nil or p196 == nil then
                        return v197, v198
                    end
                    p195.Text = "SUPREME Power"
                    p195.TextColor3 = Color3.fromRGB(0, 0, 0)
                    p195.TextStrokeColor3 = Color3.fromRGB(255, 255, 0)
                    p196.ImageColor3 = Color3.fromRGB(255, 255, 0)
                end
                return v197, v198
            end
            local v239 = "MEGA Demon"
            local v240 = Color3.fromRGB(170, 0, 0)
            if p195 == nil or p196 == nil then
                return v239, v240
            end
            p195.Text = "MEGA Demon"
            p195.TextColor3 = Color3.fromRGB(0, 0, 0)
            p195.TextStrokeColor3 = Color3.fromRGB(170, 0, 0)
            p196.ImageColor3 = Color3.fromRGB(170, 0, 0)
            return v239, v240
        end
    end,
    ["getPlayerKarmaRank"] = function(p241, p242, p243) -- name: getPlayerKarmaRank
        if p241 ~= nil and p242 ~= nil then
            local v244 = nil
            local v245 = Color3.fromRGB(255, 255, 255)
            local v246 = Color3.fromRGB(0, 0, 0)
            if (p242.Value > p241.Value and "Evil" or "Good") == "Good" then
                if p241.Value < 5 then
                    v244 = "Neutral"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Neutral"
                    p243.TextColor3 = Color3.fromRGB(255, 255, 255)
                    v245 = Color3.fromRGB(255, 255, 255)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 5 and p241.Value < 20 then
                    v244 = "Nice"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Nice"
                    p243.TextColor3 = Color3.fromRGB(85, 170, 255)
                    v245 = Color3.fromRGB(85, 170, 255)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 20 and p241.Value < 100 then
                    v244 = "Guard"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Guard"
                    p243.TextColor3 = Color3.fromRGB(85, 255, 0)
                    v245 = Color3.fromRGB(85, 255, 0)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 100 and p241.Value < 250 then
                    v244 = "Protector"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Protector"
                    p243.TextColor3 = Color3.fromRGB(255, 237, 97)
                    v245 = Color3.fromRGB(255, 237, 97)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 250 and p241.Value < 500 then
                    v244 = "Enforcer"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Enforcer"
                    p243.TextColor3 = Color3.fromRGB(170, 170, 255)
                    v245 = Color3.fromRGB(170, 170, 255)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 500 and p241.Value < 1000 then
                    v244 = "Guardian"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Guardian"
                    p243.TextColor3 = Color3.fromRGB(0, 255, 255)
                    v245 = Color3.fromRGB(0, 255, 255)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 1000 and p241.Value < 2000 then
                    v244 = "Hero"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Hero"
                    p243.TextColor3 = Color3.fromRGB(255, 217, 0)
                    v245 = Color3.fromRGB(255, 217, 0)
                    v246 = Color3.fromRGB(0, 0, 0)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 2000 and p241.Value < 5000 then
                    v244 = "Avenger"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Avenger"
                    p243.TextColor3 = Color3.fromRGB(255, 255, 255)
                    v245 = Color3.fromRGB(255, 255, 255)
                    v246 = Color3.fromRGB(170, 85, 255)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 5000 and p241.Value < 10000 then
                    v244 = "Champion"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Champion"
                    p243.TextColor3 = Color3.fromRGB(255, 255, 255)
                    v245 = Color3.fromRGB(255, 255, 255)
                    v246 = Color3.fromRGB(0, 170, 255)
                    p243.TextStrokeColor3 = v246
                elseif p241.Value >= 10000 then
                    v244 = "Peacekeeper"
                    if p243 == nil then
                        return v244
                    end
                    p243.Text = "Peacekeeper"
                    p243.TextColor3 = Color3.fromRGB(255, 255, 255)
                    v245 = Color3.fromRGB(255, 255, 255)
                    v246 = Color3.fromRGB(255, 255, 0)
                    p243.TextStrokeColor3 = v246
                end
            elseif p242.Value < 5 then
                v244 = "Neutral"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Neutral"
                p243.TextColor3 = Color3.fromRGB(255, 255, 255)
                v245 = Color3.fromRGB(255, 255, 255)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 5 and p242.Value < 20 then
                v244 = "Tough"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Tough"
                p243.TextColor3 = Color3.fromRGB(111, 0, 0)
                v245 = Color3.fromRGB(111, 0, 0)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 20 and p242.Value < 100 then
                v244 = "Dark"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Dark"
                p243.TextColor3 = Color3.fromRGB(56, 56, 56)
                v245 = Color3.fromRGB(56, 56, 56)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 100 and p242.Value < 250 then
                v244 = "Evil"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Evil"
                p243.TextColor3 = Color3.fromRGB(141, 94, 0)
                v245 = Color3.fromRGB(141, 94, 0)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 250 and p242.Value < 500 then
                v244 = "Hunter"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Hunter"
                p243.TextColor3 = Color3.fromRGB(158, 0, 0)
                v245 = Color3.fromRGB(158, 0, 0)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 500 and p242.Value < 1000 then
                v244 = "Stealth"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Stealth"
                p243.TextColor3 = Color3.fromRGB(0, 40, 121)
                v245 = Color3.fromRGB(0, 40, 121)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 1000 and p242.Value < 2000 then
                v244 = "Enraged"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Enraged"
                p243.TextColor3 = Color3.fromRGB(188, 62, 0)
                v245 = Color3.fromRGB(188, 62, 0)
                v246 = Color3.fromRGB(0, 0, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 2000 and p242.Value < 5000 then
                v244 = "Unleashed"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Unleashed"
                p243.TextColor3 = Color3.fromRGB(0, 0, 0)
                v245 = Color3.fromRGB(0, 0, 0)
                v246 = Color3.fromRGB(170, 0, 255)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 5000 and p242.Value < 10000 then
                v244 = "Rookie Crusher"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Rookie Crusher"
                p243.TextColor3 = Color3.fromRGB(0, 0, 0)
                v245 = Color3.fromRGB(0, 0, 0)
                v246 = Color3.fromRGB(85, 255, 0)
                p243.TextStrokeColor3 = v246
            elseif p242.Value >= 10000 then
                v244 = "Gym Crusher"
                if p243 == nil then
                    return v244
                end
                p243.Text = "Gym Crusher"
                p243.TextColor3 = Color3.fromRGB(0, 0, 0)
                v245 = Color3.fromRGB(0, 0, 0)
                v246 = Color3.fromRGB(255, 0, 0)
                p243.TextStrokeColor3 = v246
            end
            if p243 ~= nil then
                if v244 == "Neutral" then
                    p243.Visible = false
                    return v244, v245, v246
                end
                p243.Visible = true
            end
            return v244, v245, v246
        end
    end,
    ["findOriginalPowerUp"] = function(p247) -- name: findOriginalPowerUp
        if p247 == nil then
            return nil
        end
        local v248 = game:GetService("ServerStorage"):WaitForChild("PowerUps")
        local v249 = nil
        for _, v250 in pairs(v248:GetChildren()) do
            if v249 ~= nil then
                break
            end
            if v250 ~= nil and v250:IsA("Folder") then
                for _, v251 in pairs(v250:GetChildren()) do
                    if v251 ~= nil and (v251:IsA("ParticleEmitter") and v251.Name == p247) then
                        v249 = v251
                        break
                    end
                end
            end
        end
        return v249
    end,
    ["determinePlayerKarmaSide"] = function(p252) -- name: determinePlayerKarmaSide
        local v253 = "Good"
        if p252 ~= nil then
            local v254 = p252:FindFirstChild("goodKarma")
            local v255 = p252:FindFirstChild("evilKarma")
            v253 = v254 ~= nil and (v255 ~= nil and v255.Value > v254.Value) and "Evil" or v253
        end
        return v253
    end,
    ["addGoodKarma"] = function(p256, p257) -- name: addGoodKarma
        local v258 = p256:FindFirstChild("goodKarma")
        local v259 = p256:FindFirstChild("muscleEvent")
        if v258 ~= nil then
            v258.Value = v258.Value + p257
        end
        if v259 ~= nil then
            v259:FireClient(p256, "showGoodKarma", p257)
        end
    end,
    ["addEvilKarma"] = function(p260, p261) -- name: addEvilKarma
        local v262 = p260:FindFirstChild("evilKarma")
        local v263 = p260:FindFirstChild("muscleEvent")
        if v262 ~= nil then
            v262.Value = v262.Value + p261
        end
        if v263 ~= nil then
            v263:FireClient(p260, "showEvilKarma", p261)
        end
    end,
    ["calculateNextPetLevelExp"] = function(p264, p265) -- name: calculateNextPetLevelExp
        local v266 = nil
        if p264 == nil or p265 == nil then
            return v266
        end
        local v267 = game:GetService("ReplicatedStorage"):WaitForChild("petExpMultipliers"):FindFirstChild(p265)
        local v268
        if v267 == nil then
            v268 = nil
        else
            v268 = p264 * v267.Value
        end
        return v268
    end,
    ["calculateNextPowerUpLevelExp"] = function(p269, p270) -- name: calculateNextPowerUpLevelExp
        if p269 == nil or p270 == nil then
            return nil
        end
        local v271 = 300 + p269 * 300
        if p270 ~= "Basic" then
            if p270 == "Advanced" then
                v271 = v271 * 2
            elseif p270 == "Rare" then
                v271 = v271 * 3
            elseif p270 == "Epic" then
                v271 = v271 * 4
            elseif p270 == "Unique" then
                v271 = v271 * 5
            end
        end
        return v271
    end,
    ["findEmptyPetSlot"] = function(p272, p273) -- name: findEmptyPetSlot
        local v274 = nil
        local v275 = p272.Parent
        if v275 ~= nil and v275.Parent == game.Players then
            local v276 = 2
            if v275.MembershipType == Enum.MembershipType.Premium then
                v276 = v276 + 1
            end
            if p272:FindFirstChild("+2 Pet Slots") then
                v276 = v276 + 2
            end
            local v277 = v275:FindFirstChild("ultimatesFolder")
            if v277 ~= nil then
                local v278 = v277:FindFirstChild("+1 Pet Slot")
                if v278 ~= nil then
                    v276 = v276 + v278.Value
                end
            end
            local v279 = {}
            for v280 = 1, 8 do
                local v281 = "pet" .. tostring(v280)
                table.insert(v279, v280, v281)
            end
            local v282 = 0
            local v283 = {}
            for _, v284 in pairs(v279) do
                local v285 = p273:FindFirstChild(v284)
                if v285 ~= nil then
                    v282 = v282 + 1
                    v283[v282] = v285
                end
            end
            local v286 = 0
            for _, v287 in pairs(v283) do
                if v287 ~= nil and (v287:IsA("ObjectValue") and v287.Value ~= nil) then
                    v286 = v286 + 1
                end
            end
            if v286 < v276 == true then
                for _, v288 in pairs(v283) do
                    if v288 ~= nil and (v288:IsA("ObjectValue") and v288.Value == nil) then
                        return v288
                    end
                end
            end
        end
        return v274
    end,
    ["getNumberOfPets"] = function(p289, p290) -- name: getNumberOfPets
        if p289 ~= nil then
            local v291 = 0
            for _, v292 in pairs(p289:GetChildren()) do
                if v292 ~= nil and v292:IsA("Folder") then
                    for _, v293 in pairs(v292:GetChildren()) do
                        if v293 ~= nil and (v293:IsA("StringValue") and (v293.Name == p290 and v293:FindFirstChild("evolved") == nil)) then
                            v291 = v291 + 1
                        end
                    end
                end
            end
            return v291
        end
    end,
    ["getNumberOfSamePowerUp"] = function(p294, p295) -- name: getNumberOfSamePowerUp
        if p294 == nil or p295 == nil then
            return 0
        end
        local v296 = 0
        for _, v297 in pairs(p294:GetChildren()) do
            if v297 ~= nil and v297:IsA("Folder") then
                for _, v298 in pairs(v297:GetChildren()) do
                    if v298 ~= nil and (v298:IsA("ParticleEmitter") and (v298.Name == p295 and v298:FindFirstChild("evolved") == nil)) then
                        v296 = v296 + 1
                    end
                end
            end
        end
        return v296
    end,
    ["calculatePowerUpSellPrice"] = function(p299) -- name: calculatePowerUpSellPrice
        if p299 == nil or p299.Parent == nil then
            return 0
        end
        local v300 = 0
        if p299.Parent.Name == "Basic" then
            v300 = v300 + 25
        elseif p299.Parent.Name == "Advanced" then
            v300 = v300 + 60
        elseif p299.Parent.Name == "Rare" then
            v300 = v300 + 140
        elseif p299.Parent.Name == "Epic" then
            v300 = v300 + 300
        elseif p299.Parent.Name == "Unique" then
            v300 = v300 + 750
        end
        if p299:FindFirstChild("evolved") ~= nil then
            v300 = v300 * 5
        end
        return v300
    end,
    ["scaleBarbell"] = function(p301, p302) -- name: scaleBarbell
        local v303 = p302.Value
        local v304 = v303 < 1 and 1 or v303
        p301.Size = p301.Size * v304
    end,
    ["scaleMachineInteractDistance"] = function(p305, p306, p307) -- name: scaleMachineInteractDistance
        if p307 ~= nil and p307:FindFirstChild("jungleMachine") ~= nil then
            p305 = p305 * 3
        end
        local v308 = (p306 - 1) / 4
        local v309 = p305 * (v308 < 1 and 1 or v308)
        local v310 = v309 < 15 and 15 or v309
        return v310 > 100 and 100 or v310
    end,
    ["getPlayerPlatform"] = function() -- name: getPlayerPlatform
        return game:GetService("GuiService"):IsTenFootInterface() == true and "console" or (game:GetService("UserInputService").KeyboardEnabled == true and "pc" or (game:GetService("UserInputService").TouchEnabled == true and "mobile" or "pc"))
    end,
    ["addStrength"] = function(p311, p312) -- name: addStrength
        -- upvalues: (copy) v_u_1, (copy) v_u_23
        if p311 ~= nil and p312 ~= nil then
            local v313 = p311:FindFirstChild("leaderstats")
            local v314 = p311:FindFirstChild("muscleEvent")
            if v313 ~= nil and v314 ~= nil then
                local v315 = v313:FindFirstChild("Strength")
                if v315 ~= nil then
                    local v316 = p311:FindFirstChild("ultimatesFolder")
                    if v316 ~= nil then
                        local v317 = v316:FindFirstChild("Galaxy Gains")
                        if v317 ~= nil then
                            p312 = p312 * (1 + v317.Value * 10 / 100)
                        end
                    end
                    local v318 = p311:FindFirstChild("boostTimersFolder")
                    if v318 ~= nil and v318:FindFirstChild("Protein Egg") ~= nil then
                        p312 = p312 * 2
                    end
                    if v_u_1:WaitForChild("x2WeekendCrossServerUpdateFolder"):WaitForChild("remainingTimeValue").Value > 0 then
                        p312 = p312 * 2
                    end
                    v315.Value = v315.Value + p312
                    v314:FireClient(p311, "showStrength", p312)
                    v_u_23(p311, "Strength", p312)
                end
            end
        end
    end,
    ["addAgility"] = function(p319, p320) -- name: addAgility
        -- upvalues: (copy) v_u_23
        if p319 ~= nil and p320 ~= nil then
            local v321 = p319:FindFirstChild("Agility")
            local v322 = p319:FindFirstChild("muscleEvent")
            if v321 ~= nil and v322 ~= nil then
                local v323 = p319:FindFirstChild("ultimatesFolder")
                if v323 ~= nil then
                    local v324 = v323:FindFirstChild("Jungle Swift")
                    if v324 ~= nil then
                        p320 = p320 * (1 + v324.Value * 10 / 100)
                    end
                end
                local v325 = p319:FindFirstChild("boostTimersFolder")
                if v325 ~= nil and v325:FindFirstChild("Tropical Shake") ~= nil then
                    p320 = p320 * 2
                end
                v321.Value = v321.Value + p320
                v322:FireClient(p319, "showAgility", p320)
                v_u_23(p319, "Agility", p320)
            end
        end
    end,
    ["addDurability"] = function(p326, p327) -- name: addDurability
        -- upvalues: (copy) v_u_23
        if p326 ~= nil and p327 ~= nil then
            local v328 = p326:FindFirstChild("Durability")
            local v329 = p326:FindFirstChild("muscleEvent")
            if v328 ~= nil and v329 ~= nil then
                local v330 = p326:FindFirstChild("ultimatesFolder")
                if v330 ~= nil then
                    local v331 = v330:FindFirstChild("Muscle Mind")
                    if v331 ~= nil then
                        p327 = p327 * (1 + v331.Value * 10 / 100)
                    end
                end
                v328.Value = v328.Value + p327
                v329:FireClient(p326, "showDurability", p327)
                v_u_23(p326, "Durability", p327)
            end
        end
    end,
    ["addGems"] = function(p332, p333) -- name: addGems
        if p332 ~= nil and p333 ~= nil then
            local v334 = p332:FindFirstChild("Gems")
            local v335 = p332:FindFirstChild("muscleEvent")
            if v334 ~= nil and v335 ~= nil then
                v334.Value = v334.Value + p333
                v335:FireClient(p332, "showGems", p333)
            end
        end
    end,
    ["calculatePlayerHealth"] = function(p336) -- name: calculatePlayerHealth
        local v337 = 100
        if p336 ~= nil then
            local v338 = p336:FindFirstChild("Durability")
            if v338 ~= nil then
                v337 = v337 + v338.Value
            end
            local v339 = p336:FindFirstChild("equippedPets")
            if v339 ~= nil then
                local v340 = 0
                for _, v341 in pairs(v339:GetChildren()) do
                    if v341 ~= nil and (v341.Value ~= nil and (v341.Value.Parent ~= nil and (p336.Character ~= nil and v341.Value.Parent == p336.Character))) then
                        if v341.Value.Name == "Small Fry" then
                            v340 = v340 + 25
                        elseif v341.Value.Name == "Mighty Monster" then
                            v340 = v340 + 50
                        end
                    end
                end
                local v342 = p336:FindFirstChild("ultimatesFolder")
                if v342 ~= nil then
                    local v343 = v342:FindFirstChild("Infernal Health")
                    if v343 ~= nil then
                        v340 = v340 + v343.Value * 10
                    end
                end
                v337 = v337 * (v340 / 100 + 1)
            end
        end
        return v337
    end,
    ["calculatePlayerSpeed"] = function(p344) -- name: calculatePlayerSpeed
        local v345 = 16
        if p344 ~= nil then
            local v346 = p344:FindFirstChild("Agility")
            if v346 ~= nil then
                v345 = v345 + v346.Value / 75
            end
            v345 = v345 > 500 and 500 or v345
        end
        return v345
    end,
    ["checkIfGivenTimeHasPassed"] = function(p347, p348, p349) -- name: checkIfGivenTimeHasPassed
        if p347 ~= nil and p348 ~= nil then
            local v350 = false
            local v351 = os.time()
            if p349 ~= nil then
                v351 = p349
            end
            local v352 = v351 - p348
            if p349 == nil then
                print("Elapsed Time:" .. tostring(v352), "Current Server Time:" .. tostring(v351), "Earlier Time: " .. tostring(p348))
            end
            return p347 <= v352 and v352 > 0 and true or v350
        end
    end,
    ["calculatePetCapacity"] = function(p353) -- name: calculatePetCapacity
        if p353 ~= nil then
            local v354 = 0
            for _, v355 in pairs(p353:GetChildren()) do
                if v355:IsA("Folder") then
                    v354 = v354 + #v355:GetChildren()
                end
            end
            return v354
        end
    end,
    ["calculatePowerUpCapacity"] = function(p356) -- name: calculatePowerUpCapacity
        if p356 ~= nil then
            local v357 = 0
            for _, v358 in pairs(p356:GetChildren()) do
                if v358:IsA("Folder") then
                    v357 = v357 + #v358:GetChildren()
                end
            end
            return v357
        end
    end,
    ["createNewPetInstance"] = function(p359, p360, p361, p362, p363, p364, p365, p366) -- name: createNewPetInstance
        -- upvalues: (copy) v_u_42
        if p359 ~= nil and (p361 ~= nil and p363 ~= nil) then
            local v367 = Instance.new("StringValue")
            v367.Name = p359
            if p360 ~= nil then
                v367.Value = p360
            end
            local v368 = Instance.new("IntValue")
            v368.Name = "level"
            v368.Value = p361
            v368.Parent = v367
            local v369 = Instance.new("IntValue")
            v369.Name = "exp"
            v369.Value = p362
            v369.Parent = v367
            local v370
            if p365 == nil then
                v370 = nil
            else
                v370 = p365:Clone()
                v370.Parent = v367
                if p365.Parent ~= nil then
                    if p365.Parent:FindFirstChild("requiredRebirths") ~= nil then
                        p365.Parent.requiredRebirths:Clone().Parent = v367
                    end
                    if p365.Parent:FindFirstChild("untradeable") ~= nil then
                        p365.Parent.untradeable:Clone().Parent = v367
                    end
                    if p365.Parent:FindFirstChild("unsellable") ~= nil then
                        p365.Parent.unsellable:Clone().Parent = v367
                    end
                end
            end
            local v371 = Instance.new("StringValue")
            v371.Name = "chosenName"
            v371.Value = p359
            if p366 ~= nil then
                v371.Value = p366
            end
            v371.Parent = v367
            if p364 == true then
                local v372 = Instance.new("BoolValue")
                v372.Name = "evolved"
                v372.Value = true
                v372.Parent = v367
                if v370 ~= nil then
                    for _, v373 in pairs(v370:GetChildren()) do
                        if v373 ~= nil and v373:IsA("IntValue") then
                            if v373.Name == "strength" then
                                v373.Value = v373.Value * 5
                            elseif v373.Name == "durability" then
                                v373.Value = v373.Value * 5
                            elseif v373.Name == "agility" then
                                v373.Value = v373.Value * 5
                            elseif v373.Name == "damage" then
                                v373.Value = v373.Value * 5
                            elseif v373.Name == "gems" then
                                v373.Value = v373.Value * 5
                            end
                        end
                    end
                end
            end
            if v368.Value > 1 then
                v_u_42(v370, v368.Value - 1, p363.Name)
            end
            v367.Parent = p363
            return v367
        end
    end,
    ["createNewPowerUpInstance"] = function(p374, p375, p376, p377, p378) -- name: createNewPowerUpInstance
        -- upvalues: (copy) v_u_37, (copy) v_u_1
        if p374 ~= nil and p375 ~= nil then
            local v379 = p374:Clone()
            local v380
            if v379:FindFirstChild("perksFolder") == nil then
                v380 = nil
            else
                v380 = v379.perksFolder
            end
            local v381 = Instance.new("IntValue")
            v381.Name = "level"
            if p377 == nil then
                v381.Value = 1
            else
                v381.Value = p377
            end
            v381.Parent = v379
            local v382 = Instance.new("IntValue")
            v382.Name = "exp"
            if p378 == nil then
                v382.Value = 0
            else
                v382.Value = p378
            end
            v382.Parent = v379
            if p376 == true then
                local v383 = Instance.new("BoolValue")
                v383.Name = "evolved"
                v383.Value = true
                v383.Parent = v379
                if v380 ~= nil then
                    for _, v384 in pairs(v380:GetChildren()) do
                        if v384 ~= nil and v384:IsA("IntValue") then
                            if v384.Name == "strength" then
                                v384.Value = v384.Value * 5
                            elseif v384.Name == "durability" then
                                v384.Value = v384.Value * 5
                            elseif v384.Name == "agility" then
                                v384.Value = v384.Value * 5
                            elseif v384.Name == "damage" then
                                v384.Value = v384.Value * 5
                            elseif v384.Name == "gems" then
                                v384.Value = v384.Value * 5
                            end
                        end
                    end
                end
            end
            if v381.Value > 1 then
                v_u_37(v380, v381.Value - 1, p375.Name)
            end
            v379.Parent = v_u_1
            v379.Parent = p375
            return v379
        end
    end,
    ["checkIfPlayerHasEnoughStatsForPet"] = function(p385, p386) -- name: checkIfPlayerHasEnoughStatsForPet
        local v387 = p386:FindFirstChild("requiredRebirths")
        local v388 = p385:FindFirstChild("leaderstats")
        if v387 ~= nil and v388 ~= nil then
            local v389 = v388:FindFirstChild("Rebirths")
            if v389 ~= nil and v389.Value >= v387.Value then
                return true
            end
        end
        return false
    end,
    ["totalPowerUpMaxLevel"] = 20,
    ["checkIfPetIsEquipped"] = function(p390, p391) -- name: checkIfPetIsEquipped
        if p390 ~= nil and p391 ~= nil then
            local v392 = false
            local v393 = nil
            local v394 = nil
            local v395 = nil
            for _, v396 in pairs(p390:GetChildren()) do
                if v396 ~= nil and (v396:FindFirstChild("petReference") ~= nil and (v396.petReference.Value ~= nil and v396.petReference.Value == p391)) then
                    return true, v396.Value, v396, v396.petReference
                end
            end
            return v392, v393, v394, v395
        end
    end,
    ["totalMaxPetLevel"] = 20,
    ["addExpToPets"] = function(p397, p398) -- name: addExpToPets
        -- upvalues: (copy) v_u_42
        local v399 = p397:FindFirstChild("equippedPets")
        if v399 ~= nil then
            for _, v400 in pairs(v399:GetChildren()) do
                if v400 ~= nil and (v400:IsA("ObjectValue") and (v400.Value ~= nil and (v400:FindFirstChild("petReference") ~= nil and v400.petReference.Value ~= nil))) then
                    local v401 = v400.petReference.Value
                    if v401 ~= nil and (v401.Parent ~= nil and (v401:FindFirstChild("level") ~= nil and (v401:FindFirstChild("exp") ~= nil and v401.level.Value < 20))) then
                        local v402 = v401.exp.Value + p398
                        local v403 = v401.level.Value
                        local v404 = 0
                        while true do
                            local v405 = v401.Parent.Name
                            local v406 = game:GetService("ReplicatedStorage"):WaitForChild("petExpMultipliers"):FindFirstChild(v405)
                            local v407
                            if v406 == nil then
                                v407 = nil
                            else
                                v407 = v403 * v406.Value
                            end
                            if v407 > v402 or v403 >= 20 then
                                v401.level.Value = v403
                                local v408 = v403 >= 20 and 0 or v402
                                v401.exp.Value = v408
                                break
                            end
                            v402 = v402 - v407
                            v403 = v403 + 1
                            v404 = v404 + 1
                            if v402 <= 0 then
                                break
                            end
                        end
                        if v401:FindFirstChild("perksFolder") ~= nil then
                            v_u_42(v401.perksFolder, v404, v401.Parent.Name)
                        end
                        if v400:IsA("ObjectValue") and (v400.Value ~= nil and (v400.Value:IsA("Model") and v400.Value.PrimaryPart ~= nil)) then
                            local v409 = v400.Value.PrimaryPart:FindFirstChild("petGui")
                            if v409 ~= nil then
                                local v410 = v409:FindFirstChild("levelLabel")
                                if v410 ~= nil then
                                    local v411 = v401.level.Value
                                    v410.Text = "Level " .. tostring(v411)
                                end
                            end
                        end
                    end
                end
            end
        end
    end,
    ["levelUpEquippedPowerUp"] = function(p412, p413) -- name: levelUpEquippedPowerUp
        -- upvalues: (copy) v_u_37
        local v414 = p412:FindFirstChild("equippedPowerUp")
        if v414 == nil or v414.Value == nil then
            return
        end
        local v415 = v414.Value
        if v415 ~= nil and (v415.Parent ~= nil and (v415:FindFirstChild("level") ~= nil and (v415:FindFirstChild("exp") ~= nil and v415.level.Value < 20))) then
            local v416 = v415.exp.Value + p413
            local v417 = v415.level.Value
            local v418 = 0
            while true do
                local v419 = v415.Parent.Name
                local v420
                if v417 == nil or v419 == nil then
                    v420 = nil
                else
                    v420 = 300 + v417 * 300
                    if v419 ~= "Basic" then
                        if v419 == "Advanced" then
                            v420 = v420 * 2
                        elseif v419 == "Rare" then
                            v420 = v420 * 3
                        elseif v419 == "Epic" then
                            v420 = v420 * 4
                        elseif v419 == "Unique" then
                            v420 = v420 * 5
                        end
                    end
                end
                if v420 > v416 or v417 >= 20 then
                    v415.level.Value = v417
                    local v421 = v417 >= 20 and 0 or v416
                    v415.exp.Value = v421
                    break
                end
                v416 = v416 - v420
                v417 = v417 + 1
                v418 = v418 + 1
                if v416 <= 0 then
                    break
                end
            end
            if v415:FindFirstChild("perksFolder") ~= nil then
                v_u_37(v415.perksFolder, v418, v415.Parent.Name)
            end
        end
    end,
    ["checkIfPlayerCanUseMachine"] = function(p422, p423) -- name: checkIfPlayerCanUseMachine
        local v424 = false
        if p422 ~= nil and p423 ~= nil then
            if #p423:GetChildren() <= 0 then
                return true
            end
            local v425 = p422:FindFirstChild("leaderstats")
            if v425 ~= nil then
                for _, v426 in pairs(p423:GetChildren()) do
                    if v426 ~= nil then
                        local v427 = v425:FindFirstChild(v426.Name)
                        if v427 == nil then
                            v427 = p422:FindFirstChild(v426.Name)
                        end
                        if v427 ~= nil and v427.Value >= v426.Value then
                            return true
                        end
                    end
                end
            end
        end
        return v424
    end,
    ["awardBadge"] = function(p_u_428, p_u_429) -- name: awardBadge
        -- upvalues: (copy) v_u_1
        if p_u_428 ~= nil and p_u_429 ~= nil then
            local v_u_430 = game:GetService("BadgeService")
            local v431 = game:GetService("RunService")
            local v_u_432 = p_u_428:FindFirstChild("ownedBadges")
            if v431:IsStudio() == true then
                return
            end
            if v_u_432 ~= nil then
                for _, v433 in pairs(v_u_432:GetChildren()) do
                    if v433 ~= nil and (v433:IsA("IntValue") and v433.Value == p_u_429) then
                        return
                    end
                end
            end
            local v438 = coroutine.create(function()
                -- upvalues: (copy) v_u_430, (copy) p_u_428, (copy) p_u_429, (copy) v_u_432, (ref) v_u_1
                local v436, v437 = pcall(function()
                    -- upvalues: (ref) v_u_430, (ref) p_u_428, (ref) p_u_429, (ref) v_u_432, (ref) v_u_1
                    if v_u_430:UserHasBadgeAsync(p_u_428.UserId, p_u_429) == false then
                        v_u_430:AwardBadge(p_u_428.UserId, p_u_429)
                        if v_u_432 ~= nil then
                            for _, v434 in pairs(v_u_1:WaitForChild("badgeIds"):GetChildren()) do
                                if v434 ~= nil and (v434:IsA("IntValue") and v434.Value == p_u_429) then
                                    v434:Clone().Parent = v_u_432
                                    return
                                end
                            end
                            return
                        end
                    elseif v_u_432 ~= nil then
                        for _, v435 in pairs(v_u_1:WaitForChild("badgeIds"):GetChildren()) do
                            if v435 ~= nil and (v435:IsA("IntValue") and v435.Value == p_u_429) then
                                if v_u_432:FindFirstChild(v435.Name) == nil then
                                    v435:Clone().Parent = v_u_432
                                    return
                                end
                                break
                            end
                        end
                    end
                end)
                if v436 == false then
                    print(v437)
                end
            end)
            coroutine.resume(v438)
        end
    end,
    ["giveProteinBar"] = function(p439, p440, p441) -- name: giveProteinBar
        if p439 ~= nil then
            local v442 = p439:FindFirstChild("consumablesFolder")
            if v442 ~= nil then
                local v443 = Instance.new("StringValue")
                if p440 ~= nil and p440 == true then
                    local v444 = Instance.new("BoolValue")
                    v444.Name = "isGift"
                    v444.Parent = v443
                end
                if p441 ~= nil and p441 == true then
                    local v445 = Instance.new("BoolValue")
                    v445.Name = "isFortune"
                    v445.Parent = v443
                end
                v443.Value = "rbxassetid://3655924644"
                v443.Name = "Protein Bar"
                v443.Parent = v442
            end
        end
    end,
    ["giveProteinEgg"] = function(p446, p447, p448) -- name: giveProteinEgg
        if p446 ~= nil then
            local v449 = p446:FindFirstChild("consumablesFolder")
            if v449 ~= nil then
                local v450 = Instance.new("StringValue")
                if p447 ~= nil and p447 == true then
                    local v451 = Instance.new("BoolValue")
                    v451.Name = "isGift"
                    v451.Parent = v450
                end
                if p448 ~= nil and p448 == true then
                    local v452 = Instance.new("BoolValue")
                    v452.Name = "isFortune"
                    v452.Parent = v450
                end
                v450.Value = "http://www.roblox.com/asset/?id=16842794611"
                v450.Name = "Protein Egg"
                v450.Parent = v449
            end
        end
    end,
    ["giveTropicalShake"] = function(p453, p454, p455) -- name: giveTropicalShake
        if p453 ~= nil then
            local v456 = p453:FindFirstChild("consumablesFolder")
            if v456 ~= nil then
                local v457 = Instance.new("StringValue")
                if p454 ~= nil and p454 == true then
                    local v458 = Instance.new("BoolValue")
                    v458.Name = "isGift"
                    v458.Parent = v457
                end
                if p455 ~= nil and p455 == true then
                    local v459 = Instance.new("BoolValue")
                    v459.Name = "isFortune"
                    v459.Parent = v457
                end
                v457.Value = "rbxassetid://76488218649101"
                v457.Name = "Tropical Shake"
                v457.Parent = v456
            end
        end
    end,
    ["giveTOUGHBar"] = function(p460, p461, p462) -- name: giveTOUGHBar
        if p460 ~= nil then
            local v463 = p460:FindFirstChild("consumablesFolder")
            if v463 ~= nil then
                local v464 = Instance.new("StringValue")
                if p461 ~= nil and p461 == true then
                    local v465 = Instance.new("BoolValue")
                    v465.Name = "isGift"
                    v465.Parent = v464
                end
                if p462 ~= nil and p462 == true then
                    local v466 = Instance.new("BoolValue")
                    v466.Name = "isFortune"
                    v466.Parent = v464
                end
                v464.Value = "rbxassetid://3947915838"
                v464.Name = "TOUGH Bar"
                v464.Parent = v463
            end
        end
    end,
    ["giveULTRAShake"] = function(p467, p468, p469) -- name: giveULTRAShake
        if p467 ~= nil then
            local v470 = p467:FindFirstChild("consumablesFolder")
            if v470 ~= nil then
                local v471 = Instance.new("StringValue")
                if p468 ~= nil and p468 == true then
                    local v472 = Instance.new("BoolValue")
                    v472.Name = "isGift"
                    v472.Parent = v471
                end
                if p469 ~= nil and p469 == true then
                    local v473 = Instance.new("BoolValue")
                    v473.Name = "isFortune"
                    v473.Parent = v471
                end
                v471.Value = "rbxassetid://6458816914"
                v471.Name = "ULTRA Shake"
                v471.Parent = v470
            end
        end
    end,
    ["giveEnergyBar"] = function(p474, p475, p476) -- name: giveEnergyBar
        if p474 ~= nil then
            local v477 = p474:FindFirstChild("consumablesFolder")
            if v477 ~= nil then
                local v478 = Instance.new("StringValue")
                if p475 ~= nil and p475 == true then
                    local v479 = Instance.new("BoolValue")
                    v479.Name = "isGift"
                    v479.Parent = v478
                end
                if p476 ~= nil and p476 == true then
                    local v480 = Instance.new("BoolValue")
                    v480.Name = "isFortune"
                    v480.Parent = v478
                end
                v478.Value = "rbxassetid://3656052794"
                v478.Name = "Energy Bar"
                v478.Parent = v477
            end
        end
    end,
    ["giveProteinShake"] = function(p481, p482, p483) -- name: giveProteinShake
        if p481 ~= nil then
            local v484 = p481:FindFirstChild("consumablesFolder")
            if v484 ~= nil then
                local v485 = Instance.new("StringValue")
                if p482 ~= nil and p482 == true then
                    local v486 = Instance.new("BoolValue")
                    v486.Name = "isGift"
                    v486.Parent = v485
                end
                if p483 ~= nil and p483 == true then
                    local v487 = Instance.new("BoolValue")
                    v487.Name = "isFortune"
                    v487.Parent = v485
                end
                v485.Value = "rbxassetid://3656034709"
                v485.Name = "Protein Shake"
                v485.Parent = v484
            end
        end
    end,
    ["giveEnergyShake"] = function(p488, p489, p490) -- name: giveEnergyShake
        if p488 ~= nil then
            local v491 = p488:FindFirstChild("consumablesFolder")
            if v491 ~= nil then
                local v492 = Instance.new("StringValue")
                if p489 ~= nil and p489 == true then
                    local v493 = Instance.new("BoolValue")
                    v493.Name = "isGift"
                    v493.Parent = v492
                end
                if p490 ~= nil and p490 == true then
                    local v494 = Instance.new("BoolValue")
                    v494.Name = "isFortune"
                    v494.Parent = v492
                end
                v492.Value = "rbxassetid://3656062013"
                v492.Name = "Energy Shake"
                v492.Parent = v491
            end
        end
    end,
    ["calculatePetValue"] = function(p495, p496, p497) -- name: calculatePetValue
        if p495 == nil or (p496 == nil or p497 == nil) then
            return 0
        end
        local v498 = 0
        local v499 = 5
        if p495 == "Basic" then
            v498 = v498 + 20
            v499 = 10
            if p497 == true then
                v498 = v498 + 125
            end
        elseif p495 == "Advanced" then
            v498 = v498 + 40
            v499 = 15
            if p497 == true then
                v498 = v498 + 250
            end
        elseif p495 == "Rare" then
            v498 = v498 + 80
            v499 = 20
            if p497 == true then
                v498 = v498 + 500
            end
        elseif p495 == "Epic" then
            v498 = v498 + 160
            v499 = 25
            if p497 == true then
                v498 = v498 + 750
            end
        elseif p495 == "Unique" then
            v498 = v498 + 320
            v499 = 30
            if p497 == true then
                v498 = v498 + 1000
            end
        end
        return v498 + p496 * v499
    end,
    ["shortenNumber"] = v_u_77,
    ["calculateNextRebirthGems"] = function(p500) -- name: calculateNextRebirthGems
        -- upvalues: (copy) v_u_2
        return p500 == nil and 0 or v_u_2.Value + p500 * v_u_2.Value
    end,
    ["calculateNextRebirthMultiplier"] = function(p501) -- name: calculateNextRebirthMultiplier
        -- upvalues: (copy) v_u_24
        return p501 == nil and 0 or 0 + p501 * v_u_24.Value
    end,
    ["calculateRequiredRebirthStrength"] = function(p502, p503) -- name: calculateRequiredRebirthStrength
        -- upvalues: (copy) v_u_3, (copy) v_u_4
        if p502 == nil or p503 == nil then
            return nil
        end
        local v504
        if p502 == nil then
            v504 = nil
        else
            v504 = v_u_3.Value + p502 * v_u_4.Value
        end
        local v505 = p503:FindFirstChild("equippedPets")
        if v505 ~= nil then
            local v506 = 0
            for _, v507 in pairs(v505:GetChildren()) do
                if v507 ~= nil and (v507.Value ~= nil and (v507.Value.Parent ~= nil and (p503.Character ~= nil and (v507.Value.Parent == p503.Character and v507.Value.Name == "Speedy Sally")))) then
                    v506 = v506 + 10
                end
            end
            local v508 = p503:FindFirstChild("ultimatesFolder")
            if v508 ~= nil then
                local v509 = v508:FindFirstChild("Golden Rebirth")
                if v509 ~= nil then
                    v506 = v506 + v509.Value * 10
                end
            end
            local v510 = 1 - v506 / 100
            v504 = v504 * (v510 < 0.1 and 0.1 or v510)
        end
        return v504
    end,
    ["retroCalculateCharacterSize"] = function(p511) -- name: retroCalculateCharacterSize
        local v512 = (p511 - 0.9) * 600
        local v513 = 0.15 + v512 / 400
        local v514 = 0.15 + v512 / 400
        local v515 = 1 + v512 / 1600
        return p511 > 100 and 100 or p511, v513 > 150 and 150 or v513, v514 > 150 and 150 or v514, v515 > 37.5 and 37.5 or v515
    end,
    ["calculateCharacterSize"] = function(p516) -- name: calculateCharacterSize
        if p516 ~= nil then
            local v517 = 0.9 + p516 / 600
            local v518 = 0.15 + p516 / 400
            local v519 = 0.15 + p516 / 400
            local v520 = 1 + p516 / 1600
            return v517 > 100 and 100 or v517, v518 > 150 and 150 or v518, v519 > 150 and 150 or v519, v520 > 37.5 and 37.5 or v520
        end
    end,
    ["checkIfNoBodyRotation"] = function(p521, p522) -- name: checkIfNoBodyRotation
        local v523 = p521:FindFirstChild("Pushups") ~= nil or (p521:FindFirstChild("Situps") ~= nil or p521:FindFirstChild("Handstands") ~= nil)
        return v523 == false and (p522 ~= nil and (p522.Value ~= nil and (p522.Value.Parent ~= nil and (p522.Value.Parent:FindFirstChild("machineType") ~= nil and p522.Value.Parent.machineType.Value == "Pullups")))) and true or v523
    end,
    ["canPlayerAffordUltimate"] = function(p524, p525) -- name: canPlayerAffordUltimate
        if p524 ~= nil and p525 ~= nil then
            local v526 = p524:FindFirstChild("leaderstats")
            local v527 = p524:FindFirstChild("ultimatesFolder")
            if v526 ~= nil and v527 ~= nil then
                local v528 = v526:FindFirstChild("Rebirths")
                if p525:FindFirstChild("rebirthCost") ~= nil and v528 ~= nil then
                    local v529 = v527:FindFirstChild(p525.Name)
                    local v530 = v529 == nil and 0 or v529.Value
                    local v531
                    if p525 == nil or v530 == nil then
                        v531 = (1 / 0)
                    else
                        local v532 = p525:FindFirstChild("rebirthCost")
                        v531 = v532 == nil and (1 / 0) or v532.Value + v532.Value * v530
                    end
                    if v531 <= v528.Value then
                        return true
                    end
                end
            end
        end
        return false
    end,
    ["calculateUltimateRebirthCost"] = function(p533, p534) -- name: calculateUltimateRebirthCost
        if p533 ~= nil and p534 ~= nil then
            local v535 = p533:FindFirstChild("rebirthCost")
            if v535 ~= nil then
                return v535.Value + v535.Value * p534
            end
        end
        return (1 / 0)
    end,
    ["calculateUltimateRepTime"] = function(p536) -- name: calculateUltimateRepTime
        if p536 ~= nil then
            local v537 = p536:FindFirstChild("ultimatesFolder")
            if v537 ~= nil then
                local v538 = v537:FindFirstChild("+5% Rep Speed")
                if v538 ~= nil then
                    local v539 = v538.Value
                    return (v539 < 0 and 0 or v539) * 5 / 100
                end
            end
        end
        return 0
    end,
    ["calculatePetRepTimeBoost"] = function(p540) -- name: calculatePetRepTimeBoost
        if p540 ~= nil then
            local v541 = p540:FindFirstChild("equippedPets")
            if v541 ~= nil then
                local v542 = 0
                for _, v543 in pairs(v541:GetChildren()) do
                    if v543 ~= nil and (v543.Value ~= nil and (v543.Value.Parent ~= nil and (p540.Character ~= nil and (v543.Value.Parent == p540.Character and v543.Value.Name == "Swift Samurai")))) then
                        v542 = v542 + 15
                    end
                end
                return v542 / 100
            end
        end
        return 0
    end,
    ["calculatePetRebirthGainMultiplier"] = function(p544) -- name: calculatePetRebirthGainMultiplier
        if p544 ~= nil then
            local v545 = p544:FindFirstChild("equippedPets")
            if v545 ~= nil then
                local v546 = 0
                for _, v547 in pairs(v545:GetChildren()) do
                    if v547 ~= nil and (v547.Value ~= nil and (v547.Value.Parent ~= nil and (p544.Character ~= nil and (v547.Value.Parent == p544.Character and v547.Value.Name == "Tribal Overlord")))) then
                        v546 = v546 + 2
                    end
                end
                return v546
            end
        end
        return 0
    end,
    ["addBoostTimer"] = function(p548, p549, p550) -- name: addBoostTimer
        -- upvalues: (copy) v_u_1
        if p548 ~= nil and p549 ~= nil then
            local v551 = p548:FindFirstChild("boostTimersFolder")
            if v551 ~= nil then
                local v552 = v551:FindFirstChild(p549)
                local v553 = v_u_1:WaitForChild("gameTimerBoostDescs"):FindFirstChild(p549)
                if v553 ~= nil then
                    local v554 = v553:FindFirstChild("boostTime")
                    if v554 ~= nil then
                        local v555 = v554.Value
                        if p550 == nil then
                            p550 = v555
                        end
                        if v552 == nil then
                            v552 = Instance.new("IntValue")
                            v552.Name = p549
                            v552.Parent = v551
                        end
                        v552.Value = p550
                    end
                end
            end
        end
    end
}
