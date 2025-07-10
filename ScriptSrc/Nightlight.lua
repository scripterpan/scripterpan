repeat task.wait(0.25) until game:IsLoaded()

getgenv().Image = "rbxassetid://118507736312114"
getgenv().ToggleUI = "LeftControl"
task.spawn(function()
    if not getgenv().LoadedMobileUI then getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui")
        local ImageButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        OpenUI.Name = "OpenUI"
        OpenUI.Parent = game:GetService("CoreGui")
        ImageButton.Parent = OpenUI
        ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105)
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.9,0,0.1,0)
        ImageButton.Size = UDim2.new(0,50,0,50)
        ImageButton.Image = getgenv().Image
        ImageButton.Draggable = true
        UICorner.CornerRadius = UDim.new(0,200)
        UICorner.Parent = ImageButton
        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().ToggleUI,false,game)
        end)
    end
end)

-- Load Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

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

-- Fluent Window
local Window = Fluent:CreateWindow({
    Title = "Pann Hub",
    SubTitle = "Nightlight Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Notify
Fluent:Notify({
    Title = "Pann Hub",
    Content = "Script loaded successfully!",
    Duration = 4
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
Tabs.Main:AddButton({
    Title = "Collect Notes",
    Callback = function()
        local cf = Root.CFrame
        CollectNotes()
        task.wait(0.24)
        Root.CFrame = cf
    end
})

Tabs.Main:AddButton({
    Title = "Collect Coins",
    Callback = function()
        local cf = Root.CFrame
        CollectCoins()
        task.wait(0.24)
        Root.CFrame = cf
    end
})

Tabs.Main:AddButton({
    Title = "Collect Matches",
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

Tabs.Main:AddButton({
    Title = "Auto Win (Collect notes and TP to Door)",
    Callback = function()
        for i = 1, 3 do
            CollectNotes()
            if settings.CollectCoins then
                CollectCoins()
            end
            Exit()
            task.wait(0.75)
        end
    end
})


local AutoWin = false
Tabs.Main:AddToggle("AutoAllInOne", {
    Title = "Full Auto Win (Toggle)",
    Default = settings.AutoWin
}):OnChanged(function(val)
    settings.AutoWin = val
    if val then
        task.spawn(function()
            while allInOneRunning and task.wait(0.4) do
                CollectNotes()
                if settings.CollectCoins then
                    CollectCoins()
                end
                Exit()
            end
        end)
    end
end)

-- Settings Toggles
Tabs.Settings:AddToggle("CoinToggle", {
    Title = "Collect Coins",
    Default = settings.CollectCoins
}):OnChanged(function(val)
    settings.CollectCoins = val
end)

Tabs.Settings:AddToggle("FullBright", {
    Title = "Full Bright",
    Default = settings.FB
}):OnChanged(function(val)
    settings.FB = val
    game:GetService("Lighting").Ambient = val and Color3.new(1,1,1) or Color3.new(0,0,0)
end)

-- Save settings on leave
game.Players.PlayerRemoving:Connect(function(p)
    if p == lp then
        writefile("PannHubNl/Settings.json", HttpService:JSONEncode(settings))
    end
end)

