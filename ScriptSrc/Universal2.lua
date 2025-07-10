local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Mango",
    Icon = "door-open",
    Author = "Pann",
    Folder = "PannHub-WindUi",
    Size = UDim2.fromOffset(580, 460),
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
    Title = "Open Example UI",
    Icon = "monitor",
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


local Script = Window:Universal({
    Title = "Universal Scriot",
    Icon = "bird",
    Locked = false,
})

local Player = Window:Player({
    Title = "Player",
    Icon = "bird",
    Locked = false,
    })

local Aim = Window:Aimbot({
    Title = "Aimbot",
    Icon = "bird",
    Locked = false,
})

local ESP = Window:ESP({
    Title = "ESP",
    Icon = "bird",
    Locked = false,
})

local Other = Window:Other({
    Title = "Other",
    Icon = "bird",
    Locked = false,
})


local Dialog = Window:Dialog({
    Icon = "bird",
    Title = "yes",
    Content = "Content Text",
    Buttons = {
        {
            Title = "Confirm",
            Callback = function()
                print("Confirmed!")
            end,
        },
        {
            Title = "Cancel",
            Callback = function()
                print("Cancelled!")
            end,
        },
    },
})

