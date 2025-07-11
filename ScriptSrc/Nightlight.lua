-- Setup
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local Root = char:WaitForChild("HumanoidRootPart")

lp.CharacterAdded:Connect(function(c)
    char = c
    Root = c:WaitForChild("HumanoidRootPart")
end)

-- Save Settings
local HttpService = game:GetService("HttpService")
local settings = {}

if isfile("PannHubNl/Settings.json") then
    settings = HttpService:JSONDecode(readfile("PannHubNl/Settings.json"))
else
    settings = {CollectCoins = false, FB = false, AutoWin = false}
    makefolder("PannHubNl")
    writefile("PannHubNl/Settings.json", HttpService:JSONEncode(settings))
end


local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Nightlight (Horror)",
    Icon = "door-open",
    Author = "Pann Hub",
    Folder = "PannHub-Nightlight",
    Size = UDim2.fromOffset(500, 360),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    Background = "rbxassetid://132146349437310", -- rbxassetid only
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
})

Window:EditOpenButton({
    Title = "Pann Hub (Nighlight)",
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


local main = Window:Tab({
    Title = "Main",
    Icon = "scroll-text",
    Locked = false,
})

local setting = Window:Tab({
    Title = "Settings",
    Icon = "settings",
    Locked = false,
})


-- Functions
function CollectNotes()
    for i, v in pairs(workspace.Notes:GetChildren()) do
        if v:FindFirstChild("ProximityPrompt") then
            Root.CFrame = v.CFrame
            task.wait(0.25)
            fireproximityprompt(v.ProximityPrompt)
        end
    end
end

function CollectCoins()
    for i, v in pairs(workspace.House.Coins:GetChildren()) do
        local prompt = v.Main:FindFirstChild("ProximityPrompt")
        if v:FindFirstChild("Coin") and prompt then
            Root.CFrame = v.Coin.CFrame
            task.wait(0.25)
            fireproximityprompt(prompt)
        end
    end
end

function Exit()
    Root.CFrame = workspace.House.ExitPart.CFrame
    task.wait(0.25)
    fireproximityprompt(workspace.House.ExitPart.ProximityPrompt)
end


-- Buttons

local Button = main:Button({
    Title = "Collect Notes",
    Desc = "Collect All Notes For You",
    Locked = false,
    Callback = function()
        local cf = Root.CFrame
        CollectNotes()
        task.wait(0.24)
        Root.CFrame = cf
    end
})

local Button = main:Button({
    Title = "Collect Coins",
    Desc = "Collect All Coins For You",
    Locked = false,
    Callback = function()
        local cf = Root.CFrame
        CollectCoins()
        task.wait(0.24)
        Root.CFrame = cf
    end
})


local Button = main:Button({
    Title = "Collect Matches",
    Desc = "Collect All Matches For You",
    Locked = false,
    Callback = function()
        local cf = Root.CFrame
        for i, v in pairs(workspace.Matches:GetChildren()) do
            if v:IsA("Model") then
                Root.CFrame = v.Main.CFrame
                task.wait(0.24)
                fireproximityprompt(v.Main.ProximityPrompt)
            end
        end
        Root.CFrame = cf
    end
})

local Button = main:Button({
    Title = "Teleport To The Exit",
    Desc = "Teleport You To The Exit And Leave For You",
    Locked = false,
    Callback = function()
            Exit()
     end
})



local Button = main:Button({
    Title = "Auto Win",
    Desc = "Collect notes and TP to Door",
    Locked = false,
    Callback = function()
                for i = 1, 3 do
            CollectNotes()
            Exit()
            task.wait(0.75)
    end
end
})


local Toggle = main:Toggle({
    Title = "Full Auto Win",
    Desc = "Idk what's the difference between the button one and this one",
    Icon = "trophy",
    Type = "Toggle",
    Default = settings.AutoWin,
    Callback = function(val) 
        settings.AutoWin = val
    if val then
        task.spawn(function()
            while settings.AutoWin and task.wait(0.25) do
                CollectNotes()
                
                Exit()
            end
        end)
    end
    end
})


local Toggle = setting:Toggle({
    Title = "FullBright",
    Desc = "Change Brightness",
    Icon = "sun",
    Type = "Toggle",
    Default = settings.FB,
    Callback = function(val) 
            settings.FB = val
    game:GetService("Lighting").Ambient = val and Color3.new(1,1,1) or Color3.new(0,0,0)
    end
})


-- Monster ESP
local monsterESPEnabled = false
local highlights = {}

local function createHighlight(name, model)
    if highlights[name] then
        highlights[name]:Destroy()
        highlights[name] = nil
    end
    if model then
        local h = Instance.new("Highlight")
        h.Name = name .. "_Highlight"
        h.FillColor = Color3.fromRGB(255, 0, 0) -- 🔴 Red glow for monsters
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.Adornee = model
        h.Parent = game:GetService("CoreGui")
        highlights[name] = h
    end
end

task.spawn(function()
    while task.wait(0.5) do
        if monsterESPEnabled then
            local beta = workspace:FindFirstChild("Beta")
            if beta and beta:FindFirstChild("Humanoid") and beta:FindFirstChild("HumanoidRootPart") then
                createHighlight("Beta", beta)
            end

            local midnight = workspace:FindFirstChild("Midnight")
            if midnight and midnight:FindFirstChild("Humanoid") and midnight:FindFirstChild("HumanoidRootPart") then
                createHighlight("Midnight", midnight)
            end
            
            local eyesight = workspace:FindFirstChild("Eyesight")
            if eyesight and eyesight:FindFirstChild("Humanoid") and eyesight:FindFirstChild("HumanoidRootPart") then
                createHighlight("Eyesight", eyesight)
            end
        else
            for _, h in pairs(highlights) do
                h:Destroy()
            end
            highlights = {}
        end
    end
end)



local Toggle = setting:Toggle({
    Title = "ESP Monster",
    Desc = "See where the monster is",
    Icon = "eye",
    Type = "Toggle",
    Default = false,
    Callback = function(val) 
        monsterESPEnabled = val
    end
})



-- Item ESP

-- Soon maybe





-- Save settings on leave
game.Players.PlayerRemoving:Connect(function(p)
    if p == lp then
        writefile("PannHubNl/Settings.json", HttpService:JSONEncode(settings))
    end
end)
