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
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,

})   

local Tabs = {}

do
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

    
    local main = Tabs.main:Tab({ Title = "Main", Icon = "album" })
    local cook = Tabs.main:Tab({ Title = "Cook", Icon = "cooking-pot" })
    local auto = Tabs.main:Tab({ Title = "Automatic", Icon = "code" })
    local Tp = Tabs.main:Tab({ Title = "Teleport", Icon = "arrow-down-to-dot" })
    local gemisc = Tabs.misc:Tab({ Title = "General Misc", Icon = "tv-minimal"})
    local plmisc = Tabs.misc:Tab({ Title = "Player Misc", Icon = "person-standing"})
    local mul = Tabs.Other:Tab({ Title = "Multiplayer", Icon = "users-round" })
    local src = Tabs.Other:Tab({ Title = "Universal Script & Tools", Icon = "scroll-text" })
    local exec = Tabs.Other:Tab({ Title = "Built-in Executor (Ok wth)", Icon = "toggle-left" })

end
