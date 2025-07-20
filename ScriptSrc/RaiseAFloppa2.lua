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
