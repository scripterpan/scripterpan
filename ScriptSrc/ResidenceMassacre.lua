local url = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
local ok, body = pcall(function() return game:HttpGet(url) end)
if not ok or not body or body == "" then
    warn("HttpGet failed:", body)
    return
end

local f, err = loadstring(body)
if not f then
    warn("loadstring failed:", err)
    return
end

local WindUI = f()
if type(WindUI) ~= "table" then
    warn("WindUI loader returned nil or wrong type")
    return
end

local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local aPlaceI = {
    [14896802601] = true,
    [16667550979] = true
}

if not aPlaceI[game.PlaceId] then
    WindUI:Notify({
    Title = "Pann Hub (Residence Massacre)",
    Content = "Execute in Residence Massacre! (Night 1,2)",
    Duration = 3, -- 3 seconds
    Icon = "circle-alert",
})
    
    return
end


local Window = WindUI:CreateWindow({
    Title = "Residence Massacre",
    Icon = "ghost",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi-ResidenceMass",
    Size = UDim2.fromOffset(520, 360),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    Background = "", -- rbxassetid only
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
    }
})

Window:EditOpenButton({
    Title = "Pann Hub (Residence Massacre)",
    Icon = "ghost",
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

    Tabs.StatAll = Tabs.stat:Tab({ Title = "Server's Status", Icon = "server" })
    Tabs.main1 = Tabs.main:Tab({ Title = "Main", Icon = "server" })
    Tabs.visual = Tabs.main:Tab({ Title = "Visual", Icon = "eye" })
    Tabs.N1 = Tabs.main:Tab({ Title = "Night 1", Icon = "moon" })
    Tabs.N2 = Tabs.main:Tab({ Title = "Night 2", Icon = "moon" })
    Tabs.N3 = Tabs.main:Tab({ Title = "Night 3 (Soon)", Icon = "moon", Locked = true })
    Tabs.Tp = Tabs.main:Tab({ Title = "Teleport", Icon = "arrow-down-to-dot" })
    Tabs.gemisc = Tabs.misc:Tab({ Title = "Misc", Icon = "tv-minimal"})
    Tabs.plmisc = Tabs.misc:Tab({ Title = "Local Player", Icon = "person-standing"})
    Tabs.src = Tabs.Other:Tab({ Title = "Universal Script & Tools", Icon = "scroll-text" })
    
end
