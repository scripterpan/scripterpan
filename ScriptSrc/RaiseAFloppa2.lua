local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Raise A Floppa 2",
    Icon = "door-open",
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
})

Window:EditOpenButton({
    Title = "Pann Hub (Raise A Floppa 2)",
    Icon = "book-open",
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


local info = Window:Tab({
    Title = "Information",
    Icon = "book-open-text",
    Locked = false,
})

local main = Window:Tab({
    Title = "Main",
    Icon = "tool-case",
    Locked = false,
})

local cook = Window:Tab({
    Title = "Cook",
    Icon = "cooking-pot",
    Locked = false,
})

local auto = Window:Tab({
    Title = "Automatic",
    Icon = "square-function",
    Locked = false,
})


local tp = Window:Tab({
    Title = "Teleport",
    Icon = "nfc",
    Locked = false,
})

local misc = Window:Tab({
    Title = "Miscellaneous",
    Icon = "search",
    Locked = false,
})

local mul = Window:Tab({
    Title = "Multiplayer",
    Icon = "users",
    Locked = false,
})

local Other = Window:Tab({
    Title = "Other",
    Icon = "badge-plus",
    Locked = false,
})
