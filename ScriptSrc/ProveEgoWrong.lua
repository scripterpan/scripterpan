repeat task.wait(0.25) until game:IsLoaded();
getgenv().Image = "rbxassetid://118507736312114"; --put a asset id in here to make it work
getgenv().ToggleUI = "LeftControl" -- This where you can Toggle the Fluent ui library

task.spawn(function()
    if not getgenv().LoadedMobileUI == true then getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui");
        local ImageButton = Instance.new("ImageButton");
        local UICorner = Instance.new("UICorner");
        OpenUI.Name = "OpenUI";
        OpenUI.Parent = game:GetService("CoreGui");
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ImageButton.Parent = OpenUI;
        ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105);
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.9,0,0.1,0);
        ImageButton.Size = UDim2.new(0,50,0,50);
        ImageButton.Image = getgenv().Image;
        ImageButton.Draggable = true;
        ImageButton.Transparency = 1;
        UICorner.CornerRadius = UDim.new(0,200);
        UICorner.Parent = ImageButton;
        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().ToggleUI,false,game);
        end)
    end
end)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()


local Window = Fluent:CreateWindow({
    Title = "Universal ",
    SubTitle = "By Pann",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {

    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings"}) 
}

local Options = Fluent.Options


local autoPressing = false
local delayTime = 0.5 -- default delay
local loopThread

-- Delay slider
local DelaySlider = Tabs.Main:AddSlider("PressDelay", {
    Title = "Delay Between Keypress",
    Description = "Time in seconds between each press",
    Default = 0.5,
    Min = 0.1,
    Max = 2,
    Rounding = 1,
    Callback = function(Value)
        delayTime = Value
    end
})

-- Auto Press E toggle
Tabs.Main:AddToggle("AutoE", {
    Title = "Auto Press E",
    Description = "Presses the E key every X seconds",
    Default = false
}):OnChanged(function(Value)
    autoPressing = Value
    if autoPressing then
        loopThread = task.spawn(function()
            while autoPressing do
                keypress(0x45) -- E key
                task.wait(delayTime)
            end
        end)
    end
end)




-- CFrame positions to teleport to
local teleportPoints = {
    CFrame.new(-334.750458, 33.6055908, 113.340118, -0.964284778, 4.69598547e-08, -0.264867634, 5.0515542e-08, 1, -6.61278232e-09, 0.264867634, -1.97565377e-08, -0.964284778),
    CFrame.new(-334.315063, 33.4488678, 105.74482, -0.999950886, -7.68576811e-08, 0.00991090946, -7.74479787e-08, 1, -5.9176493e-08, -0.00991090946, -5.99411649e-08, -0.999950886),
    CFrame.new(-334.213501, 33.4488678, 97.6158218, -0.992202818, -5.4645291e-08, -0.124633804, -5.05247399e-08, 1, -3.62221186e-08, 0.124633804, -2.96425959e-08, -0.992202818),
    CFrame.new(-334.119324, 33.4488678, 91.9199829, 0.306591988, 2.6063967e-08, -0.951841056, 6.31451798e-08, 1, 4.77220148e-08, 0.951841056, -7.4735361e-08, 0.306591988),

    CFrame.new(-330.756256, 33.4498672, 186.024445, -0.999993265, 1.11860599e-09, -0.00367566478, 1.47002532e-09, 1, -9.56043067e-08, 0.00367566478, -9.56090602e-08, -0.999993265),
    CFrame.new(-330.296082, 33.4498596, 179.365967, 0.540169418, -4.81311702e-08, -0.841556311, -2.38868392e-09, 1, -5.87262718e-08, 0.841556311, 3.37323485e-08, 0.540169418),
    CFrame.new(-333.932373, 33.4488678, 171.091629, -0.997669697, 4.51955948e-08, -0.0682287142, 3.95630302e-08, 1, 8.39054337e-08, 0.0682287142, 8.1010576e-08, -0.997669697),
    CFrame.new(-333.863861, 33.448864, 164.152206, 0.117837436, 1.14950769e-08, -0.993032873, -2.25922552e-08, 1, 8.89483509e-09, 0.993032873, 2.13867075e-08, 0.117837436),
}

local teleporting = false
local teleportDelay = 1

-- Delay slider
local TeleportDelaySlider = Tabs.Main:AddSlider("TeleportDelay", {
    Title = "Teleport Delay (s)",
    Description = "Delay between random teleports",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Callback = function(value)
        teleportDelay = value
    end
})

-- Toggle for randomized teleport
Tabs.Main:AddToggle("AutoTeleport", {
    Title = "Random Teleport",
    Description = "Randomly teleports between positions",
    Default = false
}):OnChanged(function(value)
    teleporting = value
    if teleporting then
        task.spawn(function()
            while teleporting do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local randomCFrame = teleportPoints[math.random(1, #teleportPoints)]
                    char:MoveTo(randomCFrame.Position)
                    char.HumanoidRootPart.CFrame = randomCFrame
                    task.wait(teleportDelay)
                else
                    warn("HumanoidRootPart not found.")
                    break
                end
            end
        end)
    end
end)
