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
    Title = "Own Blue Lock And Prove Ego Wrong ",
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




-- === TELEPORT TARGETS SETUP ===
local teleportTargets = {
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 13"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 13_2"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 14"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 14_2"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 11"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 11_2"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 12"],
    workspace.Map.Tycoons["jauy4528N's Tycoon"].Tables["Table 12_2"],
}

local teleporting = false
local teleportDelay = 1

-- === SLIDER: Teleport Delay ===
Tabs.Main:AddSlider("TeleportDelay", {
    Title = "Teleport Delay (s)",
    Description = "Delay between each random teleport",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Callback = function(value)
        teleportDelay = value
    end
})

-- === TOGGLE: Enable Auto Teleport ===
Tabs.Main:AddToggle("AutoTeleport", {
    Title = "Random Table Teleport",
    Description = "Teleport to a random table every few seconds",
    Default = false
}):OnChanged(function(value)
    teleporting = value
    if teleporting then
        task.spawn(function()
            while teleporting do
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local randomTable = teleportTargets[math.random(1, #teleportTargets)]
                    if randomTable then
                        -- make sure the player is movable
                        hrp.Anchored = false

                        if char:FindFirstChildOfClass("Humanoid") then
                            char:FindFirstChildOfClass("Humanoid").Sit = false
                        end

                        -- teleport depending on object type
                        if randomTable:IsA("Model") then
                            local part = randomTable.PrimaryPart or randomTable:FindFirstChildWhichIsA("BasePart")
                            if part then
                                hrp.CFrame = part.CFrame
                            end
                        elseif randomTable:IsA("BasePart") then
                            hrp.CFrame = randomTable.CFrame
                        end
                    end
                end

                task.wait(teleportDelay)
            end
        end)
    end
end)
