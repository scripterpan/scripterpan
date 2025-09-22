local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Sol's RNG",
    Icon = "dices",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi-SolsRNG",
    Size = UDim2.fromOffset(520, 360),
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
    Title = "Pann Hub (Sol's RNG)",
    Icon = "dices",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
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

    
    Tabs.Stat = Tabs.stat:Tab({ Title = "Status", Icon = "speech" })
    Tabs.main1 = Tabs.main:Tab({ Title = "Main", Icon = "album" })
    Tabs.craft = Tabs.main:Tab({ Title = "Crafting", Icon = "pickaxe" })
    Tabs.webhook = Tabs.main:Tab({ Title = "Webhook", Icon = "webhook" })
    Tabs.gemisc = Tabs.misc:Tab({ Title = "Misc", Icon = "tv-minimal"})
    Tabs.plmisc = Tabs.misc:Tab({ Title = "Local Player", Icon = "person-standing"})
    Tabs.src = Tabs.Other:Tab({ Title = "Universal Script & Tools", Icon = "scroll-text" })

end


Tabs.Stat:Paragraph({
    Title = "Your Executor",
    Desc = identifyexecutor(),
    Locked = false,
})


local Stats = game:GetService("Stats")
local network = Stats:FindFirstChild("Network")
local RunService = game:GetService("RunService")

local paragraph = Tabs.Stat:Paragraph({
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


local paragraph = Tabs.Stat:Paragraph({
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


local Players = game:GetService("Players")
local player = Players.LocalPlayer

local paragraph = Tabs.Stat:Paragraph({
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



local paragraph = Tabs.Stat:Paragraph({
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






local webhookUrl = ""
local webhookTimer = 7200 
local webhookEnabled = false
local discordId = "" 

Tabs.webhook:Input({
    Title = "Webhook URL",
    Desc = "Put your webhook here",
    Placeholder = "Enter your webhook URL",
    InputIcon = "webhook",
    Type = "Input",
    Value = webhookUrl,
    Callback = function(input)
        webhookUrl = input
    end
})

Tabs.webhook:Input({
    Title = "Discord ID (Optional)",
    Desc = "Enter your Discord ID (numbers only)",
    Placeholder = "Your Discord ID",
    InputIcon = "user",
    Type = "Input",
    Value = discordId,
    Callback = function(input)
        discordId = input
    end
})

Tabs.webhook:Input({
    Title = "Interval (Seconds)",
    Desc = "Delay between each webhook",
    Placeholder = "Enter interval in seconds",
    InputIcon = "clock",
    Type = "Input",
    Value = tostring(webhookTimer),
    Callback = function(input)
        local numValue = tonumber(input)
        if numValue and numValue > 0 then
            webhookTimer = numValue
        end
    end
})

Tabs.webhook:Toggle({
    Title = "Enable Webhook",
    Desc = "Send webhook status",
    Icon = "webhook",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        webhookEnabled = state
        if webhookEnabled then
            task.spawn(function()
                while webhookEnabled do
                    if webhookUrl ~= "" then
                        local content = discordId ~= "" and ("<@" .. discordId .. ">") or "Webhook sent successfully!"
                        local data = {
                            ["content"] = content,
                            ["embeds"] = {{
                                ["title"] = "Sol's RNG Eon1",
                                ["description"] = "Webhook activated!",
                                ["color"] = 65280,
                                ["fields"] = {
                                    {
                                        ["name"] = "⏰ Time:",
                                        ["value"] = os.date("!%a %b %d %X %Y", os.time() + 7 * 3600) .. " GMT +7"
                                    }
                                }
                            }}
                        }
                        local jsonData = game:GetService("HttpService"):JSONEncode(data)
                        request({
                            Url = webhookUrl,
                            Method = "POST",
                            Headers = { ["Content-Type"] = "application/json" },
                            Body = jsonData
                        })
                    end
                    task.wait(webhookTimer)
                end
            end)
        end
    end
})
