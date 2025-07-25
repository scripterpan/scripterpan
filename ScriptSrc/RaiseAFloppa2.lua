local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Raise A Floppa 2",
    Icon = "cat",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi-RAF2",
    Size = UDim2.fromOffset(500, 360),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    Background = "", -- rbxassetid only
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
    }
})

Window:EditOpenButton({
    Title = "Pann Hub (Raise A Floppa 2)",
    Icon = "cat",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("#32a89d"), 
        Color3.fromHex("32a0a8")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,

})   

local Tabs = {}

do

Tabs.stat = Window:Section({
        Title = "Status",
        Opened = true,
    })
    Tabs.main = Window:Section({
        Title = "Main",
        Opened = true,
    })

    Tabs.misc = Window:Section({
        Title = "Miscellaneous",
        Opened = true,
    })
    
    
    Tabs.Other = Window:Section({
        Title = "Other",
        Opened = true,
    })

    
    Tabs.StatPlayer = Tabs.stat:Tab({ Title = "Player's Status", Icon = "speech" })
    Tabs.StatFloppa = Tabs.stat:Tab({ Title = "Floppa's Status", Icon = "cat" })
    Tabs.StatServer = Tabs.stat:Tab({ Title = "Server's Status", Icon = "server" })
    Tabs.StatOther = Tabs.stat:Tab({ Title = "Other's Status", Icon = "search" })
    Tabs.main1 = Tabs.main:Tab({ Title = "Main", Icon = "album" })
    Tabs.cook = Tabs.main:Tab({ Title = "Cook", Icon = "cooking-pot" })
    Tabs.manual = Tabs.main:Tab({ Title = "Manual", Icon = "bolt" })
    Tabs.auto = Tabs.main:Tab({ Title = "Automatic", Icon = "code" })
    Tabs.plant = Tabs.main:Tab({ Title = "Plant Related", Icon = "sprout" })
    Tabs.glitch = Tabs.main:Tab({ Title = "Glitch Portal (W.I.P)", Icon = "bomb", Locked = "true" })
    Tabs.Tp = Tabs.main:Tab({ Title = "Teleport", Icon = "arrow-down-to-dot" })
    Tabs.gemisc = Tabs.misc:Tab({ Title = "General Misc", Icon = "tv-minimal"})
    Tabs.plmisc = Tabs.misc:Tab({ Title = "Player Misc", Icon = "person-standing"})
    Tabs.mul = Tabs.Other:Tab({ Title = "Multiplayer", Icon = "users-round" })
    Tabs.src = Tabs.Other:Tab({ Title = "Universal Script & Tools", Icon = "scroll-text" })
    Tabs.exec = Tabs.Other:Tab({ Title = "Built-in Executor (Ok wth)", Icon = "toggle-left" })

end


-- setup function for teleport 
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")







-- setup for show ping and fps
local Stats = game:GetService("Stats")
local network = Stats:FindFirstChild("Network")
local RunService = game:GetService("RunService")



-- setup for something important
local Players = game:GetService("Players")
local player = Players.LocalPlayer




-- unlock
local unlocks = workspace:WaitForChild("Unlocks")





-- setup tp back
local originalCFrame = nil

local function saveOriginalPosition()
    local character = game.Players.LocalPlayer.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            originalCFrame = hrp.CFrame
        end
    end
end

local function teleportBack()
    local character = game.Players.LocalPlayer.Character
    if character and originalCFrame then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = originalCFrame
        end
    end
end


-- instant interact
local ProximityPromptService = game:GetService("ProximityPromptService")
local proximityConnection
local promptAddedConnection
local modifiedPrompts = {}



-- moodlets
local moodletFolder = workspace:WaitForChild("Floppa"):WaitForChild("Moodlets")

-- trophies 
local trophies = workspace:WaitForChild("Trophies")





-- Setup Tp to Floppa

        local function teleportToFloppa()
            local floppa = workspace:FindFirstChild("Floppa")

            if floppa then
                humanoidRootPart.CFrame = floppa.HumanoidRootPart.CFrame
            end
        end



--floppa happiness 
local happiness = floppa and floppa:FindFirstChild("Configuration") and floppa.Configuration:FindFirstChild("Happiness")

-- happiness value (for status tab)
local happinessValue = workspace.Floppa.Configuration.Happiness


-- setup interact 

function interact()
    local function getVisiblePrompt()
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") and v.Enabled and v.Parent:IsA("BasePart") then
                local dist = (hrp.Position - v.Parent.Position).Magnitude
                if dist <= v.MaxActivationDistance then
                    return v
                end
            end
        end
    end

    local prompt = getVisiblePrompt()
    if prompt then
        fireproximityprompt(prompt)
    end
end




Tabs.StatPlayer:Paragraph({
    Title = "Your Executor",
    Desc = identifyexecutor(),
    Locked = false,
})


local paragraph = Tabs.StatPlayer:Paragraph({
    Title = "Your Ping",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        local ping = nil
        pcall(function()
            local serverStats = network and network:FindFirstChild("ServerStatsItem")
            local dataPing = serverStats and serverStats:FindFirstChild("Data Ping")
            if dataPing then
                ping = dataPing:GetValue()
            end
        end)

        if ping then
            paragraph:SetDesc("Ping: " .. string.format("%.2f", ping) .. " ms")
        else
            paragraph:SetDesc("Ping: N/A")
        end

        task.wait(1)
    end
end)


local paragraph = Tabs.StatPlayer:Paragraph({
    Title = "Your FPS",
    Desc = "Loading...",
    Locked = false,
})

local fps = 60
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = now
    end
end)

task.spawn(function()
    while true do
        paragraph:SetDesc("FPS: " .. tostring(fps))
        task.wait(1)
    end
end)



local paragraph = Tabs.StatPlayer:Paragraph({
    Title = "Trophies (Badge)",
    Desc = "Checking...",
    Locked = false,
})

task.spawn(function()
    while true do
        local trophyList = trophies:GetChildren()
        local count = #trophyList

        local desc = "Trophies Unlocked: " .. count .. "\nUnlocked Trophies list:"

        for _, trophy in ipairs(trophyList) do
            desc = desc .. "\n- " .. trophy.Name
        end

        paragraph:SetDesc(desc)
        task.wait(0.25)
    end
end)








local paragraph = Tabs.StatFloppa:Paragraph({
    Title = "Floppa's Happiness",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        paragraph:SetDesc("Current Happiness: " .. 
string.format("%.2f", happinessValue.Value))
        task.wait(0)
    end
end)



local paragraph = Tabs.StatFloppa:Paragraph({
    Title = "Floppa's Moodlets",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        local currentMoodlets = {}
        for _, moodlet in ipairs(moodletFolder:GetChildren()) do
            if moodlet:IsA("BoolValue") and moodlet.Value == true then
                table.insert(currentMoodlets, moodlet.Name)
            end
        end

        if #currentMoodlets > 0 then
            paragraph:SetDesc("Moodlets: " .. table.concat(currentMoodlets, ", "))
        else
            paragraph:SetDesc("Moodlets: None")
        end

        task.wait(0.25)
    end
end)



local paragraph = Tabs.StatServer:Paragraph({
    Title = "Server Ping",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        local ping = player:GetNetworkPing() * 1000 -- Convert to milliseconds
        paragraph:SetDesc("Current Server Ping : " .. string.format("%.2f", ping) .. " ms")
        task.wait(1)
    end
end)



local paragraph = Tabs.StatServer:Paragraph({
    Title = "Player Count",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        paragraph:SetDesc("Players in Server: " .. tostring(#Players:GetPlayers()))
        task.wait(0.25)
    end
end)



local paragraph = Tabs.StatOther:Paragraph({
    Title = "DJ El Gato Cooldown",
    Desc = "Checking...",
    Locked = false,
})

task.spawn(function()
    while true do
        local elGato = unlocks:FindFirstChild("DJ El Gato")

        if elGato and elGato:FindFirstChild("Cooldown") then
            local cooldown = elGato.Cooldown.Value

            if cooldown <= 0 then
                paragraph:SetDesc("DJ El Gato is ready!")
            else
                paragraph:SetDesc("Cooldown: " .. math.floor(cooldown) .. "s")
            end
        else
            paragraph:SetDesc("Purchase DJ El Gato first")
        end

        task.wait(0.25)
    end
end)




local paragraph = Tabs.StatOther:Paragraph({
    Title = "Altar Info",
    Desc = "Checking...",
    Locked = false,
})

local function shorten(n)
    local suffixes = {"", "K", "M", "B", "T", "Qa", "Qi"}
    local i = 1
    while n >= 1000 and i < #suffixes do
        n = n / 1000
        i += 1
    end
    return string.format("%.1f%s", n, suffixes[i])
end

task.spawn(function()
    while true do
        local altar = unlocks:FindFirstChild("Altar")

        if altar and altar:FindFirstChild("Faith") and altar:FindFirstChild("Cost") then
            local currentFaith = math.floor(altar.Faith.Value)
            local nextFaith = currentFaith + 5
            local cost = shorten(altar.Cost.Value)

            paragraph:SetDesc(
                "Current Faith: " .. currentFaith .. "\n" ..
                "Next Faith: " .. nextFaith .. "\n" ..
                "Cost: " .. cost
            )
        else
            paragraph:SetDesc("Purchase Altar first!")
        end

        task.wait(0.25)
    end
end)



local paragraph = Tabs.StatOther:Paragraph({
    Title = "Floppa Inc Stats",
    Desc = "Checking...",
    Locked = false,
})

local function shorten(n)
    local suffixes = {"", "K", "M", "B", "T", "Qa", "Qi"}
    local i = 1
    while n >= 1000 and i < #suffixes do
        n = n / 1000
        i += 1
    end
    return string.format("%.2f%s", n, suffixes[i])
end

task.spawn(function()
    while true do
        local inc = unlocks:FindFirstChild("Floppa Inc")

        if inc and inc:FindFirstChild("Multiplier") and inc:FindFirstChild("Profits") and inc:FindFirstChild("GoldProfits") then
            local multiplier = math.floor(inc.Multiplier.Value)
            local profits = shorten(inc.Profits.Value)
            local goldProfits = shorten(inc.GoldProfits.Value)

            paragraph:SetDesc(
                "Multiplier: " .. multiplier .. "x\n" ..
                "Profits: $" .. profits .. "\n" ..
                "Gold Profits: $" .. goldProfits
            )
        else
            paragraph:SetDesc("Purchase Floppa Inc first!")
        end

        task.wait(0.25)
    end
end)



Tabs.main1:Toggle({
    Title = "Auto Click Floppa",
    Desc = "Get money by clicking Floppa",
    Icon = "mouse-pointer-click",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.AutoClickFloppa = val

        task.spawn(function()
            while _G.AutoClickFloppa do
                local floppa = workspace:FindFirstChild("Floppa")
                if floppa then
                    local clickDetector = floppa:FindFirstChild("ClickDetector")
                    if clickDetector then
                        fireclickdetector(clickDetector)
                    end
                end
                task.wait()
            end
        end)
    end
})


Tabs.main1:Toggle({
    Title = "Auto Click Baby Floppa",
    Desc = "Get money by clicking Baby Floppa",
    Icon = "mouse-pointer-click",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.AutoClickBabyFloppa = val

        task.spawn(function()
            while _G.AutoClickBabyFloppa do
                for _, v in pairs(game.Workspace.Unlocks:GetChildren()) do
                    if v.Name == "Baby Floppa" and v:FindFirstChild("ClickDetector") then
                        fireclickdetector(v.ClickDetector)
                    end
                end
                task.wait()
            end
        end)
    end
})


Tabs.main1:Toggle({
    Title = "Auto Collect Money",
    Desc = "Automatically collects money that drops from both Baby Floppa and Floppa",
    Icon = "hand-coins",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.AutoCollectMoney = val

        task.spawn(function()
            while _G.AutoCollectMoney do
                for _, v in pairs(workspace:GetChildren()) do
                    if (v.Name:find("Money") or v.Name == "Money Bag" or v.Name == "Gold") 
                        and v:FindFirstChildWhichIsA("TouchTransmitter") then

                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
                task.wait()
            end
        end)
    end
})


Tabs.main1:Toggle({
    Title = "Auto Collect Gem",
    Desc = "Automatically collects gems that drops from Queen Floppa",
    Icon = "gem",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.AutoCollectGem = val

        task.spawn(function()
            while _G.AutoCollectGem do
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "Ruby" or v.Name == "Diamond" or v.Name == "Emerald" or v.Name == "Sapphire" then
                        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), v, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), v, 1)
                    end
                end
                task.wait()
            end
        end)
    end
})






Tabs.manual:Button({
    Title = "Pet Floppa",
    Desc = "Teleport to Floppa and pet it to increase its happiness",
    Callback = function() 
        saveOriginalPosition()
        teleportToFloppa()
        task.wait(0.2)
        interact()
        task.wait(0.2)
        teleportBack()
end
})





Tabs.manual:Button({
    Title = "Floppa's Moodlets",
    Desc = "Feed Floppa Hot Chocolate, Lemonade When Floppa Is Cold, Hot",
    Callback = function() 
saveOriginalPosition()
        humanoidRootPart.CFrame = CFrame.new(-5.52987146, 69.0936737, -108.875877, 0.307733119, 1.24310662e-09, 0.9514727, -2.64562194e-09, 1, -4.50839088e-10, -0.9514727, -2.37849895e-09, 0.307733119)

        task.wait(0.2)

        interact()

        task.wait(0.2)

        teleportToFloppa()

        task.wait(0.2)

        interact()

        task.wait(0.2)

        teleportBack()
end
})


Tabs.manual:Button({
    Title = "Activate Meteorite Magnet",
    Desc = "Activate Meteorite Magnet if purchase",
    Callback = function() 
        local function hasMeteoriteMagnet()
            local meteoriteMagnet = workspace.Unlocks:FindFirstChild("Meteor Magnet")
            return meteoriteMagnet ~= nil
        end

        if hasMeteoriteMagnet() then
            saveOriginalPosition()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.8612709, 153.73613, -41.5506172)
            task.wait(0.2)
            interact()
            task.wait(0.2)
            teleportBack()
        else
            WindUI:Notify({
                Title = "Pann Hub (Raise A Floppa 2)",
                Content = "You need to have the Meteorite Magnet purchased before using this!",
                Icon = "circle-alert",
                Duration = 5,
            })
        end
    end
})

Tabs.manual:Button({
    Title = "Throw DJ El Gato's Party",
    Desc = "Throw DJ El Gato's Party if DJ El Gato is purchased",
    Callback = function() 
        local function hasDJElGato()
            local DJElgato = workspace.Unlocks:FindFirstChild("DJ El Gato")
            return DJElgato ~= nil
        end

        if hasDJElGato() then
            local DJElgato = workspace.Unlocks:FindFirstChild("DJ El Gato")
            
            if DJElgato:FindFirstChild("Cooldown") and DJElgato.Cooldown.Value > 0 then
    local cooldownTime = math.floor(DJElgato.Cooldown.Value)
    WindUI:Notify({
        Title = "Pann Hub (Raise A Floppa 2)",
        Content = "DJ El Gato is still on cooldown! Time left: " .. cooldownTime .. "s",
        Icon = "clock",
        Duration = 5,
    })
    return
end

            saveOriginalPosition()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-81.2888412, 76.0521393, -41.9822617, 0.66582495, -6.3948292e-08, -0.746107996, 5.74261918e-08, 1, -3.44621682e-08, 0.746107996, -1.99003694e-08, 0.66582495)
            task.wait(0.2)
            interact()
            task.wait(0.2)
            teleportBack()
        else
            WindUI:Notify({
                Title = "Pann Hub (Raise A Floppa 2)",
                Content = "You need to have DJ El Gato purchased before using this!",
                Icon = "circle-alert",
                Duration = 5,
            })
        end
    end
})



Tabs.auto:Toggle({
    Title = "Auto Pet Floppa",
    Desc = "Automatically teleports to Floppa and pet it if happiness is below 50",
    Icon = "cat",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        if val then
            task.spawn(function()
                local hasPetted = false

                while val do
                    local floppa = workspace:FindFirstChild("Floppa")
                    local happiness = floppa and floppa:FindFirstChild("Configuration") and floppa.Configuration:FindFirstChild("Happiness")

                    if floppa and happiness then
                        if happiness.Value < 50 and not hasPetted then
                            hasPetted = true
                            saveOriginalPosition()
                            teleportToFloppa()
                            task.wait(0.5)
                            interact()
                            task.wait(0.2)
                            teleportBack()
                        elseif happiness.Value >= 50 then
                            hasPetted = false
                        end
                    end

                    task.wait(0.1)
                end
            end)
        end
    end
})



Tabs.auto:Toggle({
    Title = "Auto Collect Milk",
    Desc = "Automatically collects milk crates from Milk Delivery",
    Icon = "milk",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.AutoCollectMilk = val

        task.spawn(function()
            while _G.AutoCollectMilk do
                local milkDelivery = workspace:FindFirstChild("Milk Delivery")
                if milkDelivery and milkDelivery:FindFirstChild("Crate") then
                    for _, v in ipairs(milkDelivery:GetChildren()) do
                        if v.Name == "Crate" and v:FindFirstChild("ProximityPrompt") then
                            saveOriginalPosition()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                            interact()
                            task.wait(0.25)
                            teleportBack()
                        end
                    end
                end
                       task.wait()
            end
        end)
    end
})

Tabs.auto:Toggle({
    Title = "Auto Clean Poop",
    Desc = "Automatically cleans up poop from the Litter Box and the floor",
    Icon = "trash",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.AutoClearPoop = val

        task.spawn(function()
            while _G.AutoClearPoop do
                -- Clean from Litter Box
                local keyParts = workspace:FindFirstChild("Key Parts")
                if keyParts then
                    local litterBox = keyParts:FindFirstChild("Litter Box")
                    if litterBox then
                        for _, v in pairs(litterBox:GetChildren()) do
                            if v.Name:find("Poop") and v:FindFirstChild("PoopPart") and v:FindFirstChild("ProximityPrompt") then
                                local char = game.Players.LocalPlayer.Character
                                if char and char:FindFirstChild("HumanoidRootPart") then
                                    char.HumanoidRootPart.CFrame = v.PoopPart.CFrame
                                    fireproximityprompt(v.ProximityPrompt)
                                end
                            end
                        end
                    end
                end

                -- Clean from world floor
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("Poop") and v:FindFirstChild("PoopPart") and v:FindFirstChild("ProximityPrompt") then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = v.PoopPart.CFrame
                            fireproximityprompt(v.ProximityPrompt)
                        end
                    end
                end
                task.wait()
            end
        end)
    end
})




Tabs.plant:Toggle({
    Title = "Auto Pickup Seed",
    Desc = "Automatically picks up seeds",
    Icon = "bean",
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
        _G.AutoPickUpSeeds = Value

        task.spawn(function()
            while _G.AutoPickUpSeeds do
                for _, v in ipairs(workspace.Seeds:GetChildren()) do
                    if v:FindFirstChild("ProximityPrompt") then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 2.5, 0)
                            fireproximityprompt(v.ProximityPrompt)
                        end
                    end
                end
                task.wait()
            end
        end)
    end
})


Tabs.plant:Toggle({
    Title = "Auto Plant Seed",
    Desc = "Automatically plants seeds in empty planters",
    Icon = "bean",
    Type = "Toggle",
    Default = false,
    Callback = function(Val)
        _G.AutoPlantSeeds = Val

        task.spawn(function()
            while _G.AutoPlantSeeds do
                local Seeds = {}
                local player = game.Players.LocalPlayer

                for _, item in ipairs(player.Character:GetChildren()) do
                    if item.Name:match("Seed") or item.Name:match("Spore") then
                        table.insert(Seeds, item)
                    end
                end
                for _, item in ipairs(player.Backpack:GetChildren()) do
                    if item.Name:match("Seed") or item.Name:match("Spore") then
                        table.insert(Seeds, item)
                    end
                end

                for _, seed in ipairs(Seeds) do
                    seed.Parent = player.Character
                end

                for _, planter in ipairs(workspace.Unlocks:GetChildren()) do
                    if planter.Name:match("Planter") and #Seeds > 0 then
                        if planter:FindFirstChild("Plant") and (planter.Plant.Value == nil or planter.Plant.Value == "") then
                            player.Character.HumanoidRootPart.CFrame = planter.Soil.CFrame * CFrame.new(-1, -5, 0)
                            fireproximityprompt(planter.Soil:FindFirstChild("ProximityPrompt"))
                        end
                    end
                end
                task.wait()
            end
        end)
    end
})


Tabs.plant:Toggle({
    Title = "Auto Harvest Plant",
    Desc = "Automatically harvests fully grown plants",
    Icon = "bean",
    Type = "Toggle",
    Default = false,
    Callback = function(Val)
        _G.AutoHarvestPlants = Val

        task.spawn(function()
            while _G.AutoHarvestPlants do
                for _, planter in ipairs(workspace.Unlocks:GetChildren()) do
                    if planter.Name:match("Planter") and planter:FindFirstChild("Plant") and planter:FindFirstChild("Growth") then
                        if planter.Plant.Value ~= nil and planter.Growth.Value == 100 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = planter.Soil.CFrame * CFrame.new(-1, -5, 0)
                            fireproximityprompt(planter.Soil:FindFirstChild("ProximityPrompt"))
                        end
                    end
                end
                task.wait()
            end
        end)
    end
})




Tabs.Tp:Button({
    Title = "House",
    Desc = "Teleport To House",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-61.4003258, 73.4750061, -37.8793678, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end
})

Tabs.Tp:Button({
    Title = "1st Basement",
    Desc = "Teleport To 1st Basement",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-67.2391968, 55.4000168, -39.330204, 0.0412380993, 4.33183925e-16, -0.999149323, -9.00663685e-16, 1, 3.96379444e-16, 0.999149323, 8.83551608e-16, 0.0412380993)
    end
})

Tabs.Tp:Button({
    Title = "2nd Basement",
    Desc = "Teleport To 2nd Basement",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-61.9028969, 35.9000168, -38.1604042, 0.392780244, 1.67481833e-08, -0.919632375, -3.26389724e-08, 1, 4.27153291e-09, 0.919632375, 2.83380803e-08, 0.392780244)
    end
})

Tabs.Tp:Button({
    Title = "1st Upper Floor",
    Desc = "Teleport To 1st Upper Floor",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-62.7135963, 91.4000168, -30.2685719, -0.469526678, -2.73245995e-08, -0.882918298, -5.78674388e-08, 1, -1.74752851e-10, 0.882918298, 5.10101685e-08, -0.469526678)
    end
})

Tabs.Tp:Button({
    Title = "2nd Upper Floor",
    Desc = "Teleport To 2nd Upper Floor",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-61.0160217, 110.500015, -36.4459419, 0.284452379, -7.96052557e-09, -0.958690166, -3.11641237e-08, 1, -1.75502315e-08, 0.958690166, 3.48689433e-08, 0.284452379)
    end
})

Tabs.Tp:Button({
    Title = "Roof",
    Desc = "Teleport To Roof",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-53.264492, 145.400024, -41.4740868, -0.371924132, -9.61286273e-10, -0.928263128, -8.72383388e-10, 1, -6.86040169e-10, 0.928263128, 5.54646495e-10, -0.371924132)
    end
})

Tabs.Tp:Button({
    Title = "Patio",
    Desc = "Teleport To Patio",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-63.1400528, 91.4000092, -90.8524628, 0.986670196, 8.35140401e-09, 0.162732586, -1.94483754e-08, 1, 6.6598389e-08, -0.162732586, -6.88755293e-08, 0.986670196)
    end
})





Tabs.Tp:Button({
    Title = "Market",
    Desc = "Teleport To Market",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28.0548782, 70.1997757, -108.054405, 0.786984861, 1.86600291e-09, -0.616972327, 4.16374135e-08, 1, 5.61354447e-08, 0.616972327, -6.98668785e-08, 0.786984861)
    end
})


Tabs.Tp:Button({
    Title = "Jinx's Cauldron",
    Desc = "Teleport To Jinx's Cauldron",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-114.476074, 68.593689, -144.418213, -0.425411254, 3.78284035e-08, -0.90500015, 3.78207954e-09, 1, 4.00215008e-08, 0.90500015, 1.3602814e-08, -0.425411254)
    end
})


Tabs.Tp:Button({
    Title = "Backroom",
    Desc = "Teleport To Backroom",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-248.705948, -1216.1001, -52.4668922, 0.747585952, -3.66916169e-08, -0.66416508, 2.22550529e-08, 1, -3.01943786e-08, 0.66416508, 7.79186315e-09, 0.747585952)
    end
})



Tabs.Tp:Button({
    Title = "Space",
    Desc = "Teleport To Space",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-42173.7617, 529.839417, -118.53688, 0.966301262, -1.5619916e-08, 0.257413775, 6.48822107e-09, 1, 3.63241597e-08, -0.257413775, -3.34299237e-08, 0.966301262)
    end
})





local function makePromptInstant(prompt)
    if not modifiedPrompts[prompt] then
        modifiedPrompts[prompt] = {
            HoldDuration = prompt.HoldDuration,
            RequiresLineOfSight = prompt.RequiresLineOfSight,
            ClickablePrompt = prompt.ClickablePrompt
        }
    end

    prompt.HoldDuration = 0
    prompt.RequiresLineOfSight = false
    prompt.ClickablePrompt = true
end

local function restorePrompt(prompt)
    local original = modifiedPrompts[prompt]
    if original then
        prompt.HoldDuration = original.HoldDuration
        prompt.RequiresLineOfSight = original.RequiresLineOfSight
        prompt.ClickablePrompt = original.ClickablePrompt
        modifiedPrompts[prompt] = nil
    end
end

local function toggleInstantInteract(enabled)
    if enabled then
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                makePromptInstant(obj)
            end
        end  
        
        proximityConnection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)

        promptAddedConnection = game.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                makePromptInstant(obj)
            end
        end)
    else

        if proximityConnection then
            proximityConnection:Disconnect()
            proximityConnection = nil
        end
        if promptAddedConnection then
            promptAddedConnection:Disconnect()
            promptAddedConnection = nil
        end

        for prompt, _ in pairs(modifiedPrompts) do
            restorePrompt(prompt)
        end
    end
end


Tabs.gemisc:Toggle({
    Title = "Instant Interact",
    Desc = "Interact with anything without a cooldown",
    Icon = "hand",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        toggleInstantInteract(state)
    end
})









local infiniteJumpEnabled = false
local humanoid = nil
local conn = nil

local function enableInfiniteJump()
    if conn then conn:Disconnect() end
    conn = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infiniteJumpEnabled and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function setupCharacter(char)
    humanoid = char:WaitForChild("Humanoid", 5)
    if infiniteJumpEnabled then
        enableInfiniteJump()
    end
end

player.CharacterAdded:Connect(function(char)
    setupCharacter(char)
end)

if player.Character then
    setupCharacter(player.Character)
end

Tabs.plmisc:Toggle({
    Title = "Infinite Jump",
    Desc = "Toggle Infinite Jump",
    Icon = "arrow-big-up-dash",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
        if state then
            if player.Character then
                setupCharacter(player.Character)
            end
        else
            if conn then conn:Disconnect() end
        end
    end
})













local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local noclipConnection
local originalCollisions = {}


local function saveOriginalCollisions()
    originalCollisions = {}
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalCollisions[part] = part.CanCollide
            end
        end
    end
end


local function startNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
    end

    saveOriginalCollisions()

    noclipConnection = RunService.Stepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function stopNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    for part, canCollide in pairs(originalCollisions) do
        if part and part:IsA("BasePart") then
            part.CanCollide = canCollide
        end
    end
    originalCollisions = {}
end


Tabs.plmisc:Toggle({
    Title = "Noclip",
    Desc = "Walk Through Objects",
    Icon = "expand",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            startNoclip()
        else
            stopNoclip()
        end
    end
})

-- Handle respawn
LocalPlayer.CharacterAdded:Connect(function()
    repeat task.wait() until LocalPlayer.Character:FindFirstChild("Humanoid")
    saveOriginalCollisions()
    if Toggle.Value then
        startNoclip()
    end
end)




local speedEnabled = false
local jumpEnabled = false
local gravityEnabled = false


local defaultSpeed = 16
local defaultJumpPower = 50
local defaultGravity = 196.2


local desiredSpeed = defaultSpeed
local desiredJumpPower = defaultJumpPower
local desiredGravity = defaultGravity


local function setSpeed(speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

local function setJumpPower(power)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local hum = player.Character:FindFirstChild("Humanoid")
        hum.UseJumpPower = true
        hum.JumpPower = power
    end
end

local function setGravity(g)
    workspace.Gravity = g
end


player.CharacterAdded:Connect(function()
    repeat task.wait() until player.Character:FindFirstChild("Humanoid")
    if speedEnabled then setSpeed(desiredSpeed) end
    if jumpEnabled then setJumpPower(desiredJumpPower) end
    if gravityEnabled then setGravity(desiredGravity) end
end)


local SpeedInput
local JumpInput
local GravityInput

-- speed
Tabs.plmisc:Section({ Title = "Speed", Icon = "zap" })


Tabs.plmisc:Toggle({
    Title = "Speed Boost",
    Desc = "Enable speed boost",
    Icon = "zap",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        speedEnabled = state
        if state then
            setSpeed(desiredSpeed)
            task.spawn(function()
                while speedEnabled do
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        if player.Character.Humanoid.WalkSpeed ~= desiredSpeed then
                            setSpeed(desiredSpeed)
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            setSpeed(defaultSpeed)
        end
    end
})

Tabs.plmisc:Input({
    Title = "Set Walk Speed",
    Desc = "Type your speed value here (1–500)",
    Placeholder = tostring(defaultSpeed),
    InputIcon = "chevrons-up",
    Type = "Input",
    Value = tostring(desiredSpeed),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 500 then
            desiredSpeed = num
            if speedEnabled then
                setSpeed(desiredSpeed)
            end
        end
    end
})

-- Jumppower
Tabs.plmisc:Section({ Title = "Jump Power", Icon = "person-standing" })

Tabs.plmisc:Toggle({
    Title = "Jump Boost",
    Desc = "Enable jump boost",
    Icon = "person-standing",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        jumpEnabled = state
        if state then
            setJumpPower(desiredJumpPower)
            task.spawn(function()
                while jumpEnabled do
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        if player.Character.Humanoid.JumpPower ~= desiredJumpPower then
                            setJumpPower(desiredJumpPower)
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            setJumpPower(defaultJumpPower)
        end
    end
})

Tabs.plmisc:Input({
    Title = "Set Jump Power",
    Desc = "Type jump power value (1–500)",
    Placeholder = tostring(defaultJumpPower),
    InputIcon = "person-standing",
    Type = "Input",
    Value = tostring(desiredJumpPower),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 500 then
            desiredJumpPower = num
            if jumpEnabled then
                setJumpPower(desiredJumpPower)
            end
        end
    end
})


-- Gravity 
Tabs.plmisc:Section({ Title = "Gravity", Icon = "clock-arrow-down" })

Tabs.plmisc:Toggle({
    Title = "Change Gravity",
    Desc = "Enable gravity changer",
    Icon = "clock-arrow-down",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        gravityEnabled = state
        if state then
            setGravity(desiredGravity)
            task.spawn(function()
                while gravityEnabled do
                    if workspace.Gravity ~= desiredGravity then
                        setGravity(desiredGravity)
                    end
                    task.wait(0.1)
                end
            end)
        else
            setGravity(defaultGravity)
        end
    end
})

Tabs.plmisc:Input({
    Title = "Set Gravity",
    Desc = "Type gravity value (0–500)",
    Placeholder = tostring(defaultGravity),
    InputIcon = "clock-arrow-down",
    Type = "Input",
    Value = tostring(desiredGravity),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 0 and num <= 500 then
            desiredGravity = num
            if gravityEnabled then
                setGravity(desiredGravity)
            end
        end
    end
})




