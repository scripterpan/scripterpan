repeat task.wait(0.25) until game:IsLoaded();
getgenv().Image = "rbxassetid://14670814118"; --put a asset id in here to make it work
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
    Title = "The Mimic ",
    SubTitle = "By Pann",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {

    MAIN = Window:AddTab({ Title = "Main", Icon = "" }),
    B1C1 = Window:AddTab({ Title = "Book 1 Chapter 1", Icon = ""}),
    B1C2 = Window:AddTab({ Title = "Book 1 Chapter 2", Icon = ""}),
    B1C3 = Window:AddTab({ Title = "Book 1 Chapter 3", Icon = ""}),
    B1C4 = Window:AddTab({ Title = "Book 1 Chapter 4", Icon = ""}),
    B2C1 = Window:AddTab({ Title = "Book 2 Chapter 1", Icon = ""}),
    B2C2 = Window:AddTab({ Title = "Book 2 Chapter 2", Icon = ""}),
    B2C3 = Window:AddTab({ Title = "Book 2 Chapter 3", Icon = ""}),
    Spec = Window:AddTab({ Title = "Jigoku", Icon = ""}),
    Lore = Window:AddTab({ Title = "The Witch Trials", Icon = ""}),
    eve2 = Window:AddTab({ Title = "Halloween Trials", Icon = ""}),
    eve2 = Window:AddTab({ Title = "Nightmare Circus", Icon = ""}),
    eve3 = Window:AddTab({ Title = "Christmas Trials", Icon = ""}),
    Cre = Window:AddTab({ Title = "Credit", Icon = ""}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do

Tabs.MAIN:AddButton({
    Title = "Players ESP",
    Description = "Self Explained (Can't be toggle because im lazy to makeit)",
    Callback = function()
        local FillColor = Color3.fromRGB(175,25,255)
        local DepthMode = "AlwaysOnTop"
        local FillTransparency = 0.5
        local OutlineColor = Color3.fromRGB(255,255,255)
        local OutlineTransparency = 0

        local CoreGui = game:FindService("CoreGui")
        local Players = game:FindService("Players")
        local lp = Players.LocalPlayer
        local connections = {}

        local Storage = Instance.new("Folder")
        Storage.Parent = CoreGui
        Storage.Name = "Highlight_Storage"

        local function Highlight(plr)
            local Highlight = Instance.new("Highlight")
            Highlight.Name = plr.Name
            Highlight.FillColor = FillColor
            Highlight.DepthMode = DepthMode
            Highlight.FillTransparency = FillTransparency
            Highlight.OutlineColor = OutlineColor
            Highlight.OutlineTransparency = 0
            Highlight.Parent = Storage

            local plrchar = plr.Character
            if plrchar then
                Highlight.Adornee = plrchar
            end

            connections[plr] = plr.CharacterAdded:Connect(function(char)
                Highlight.Adornee = char
            end)
        end

        Players.PlayerAdded:Connect(Highlight)
        for i,v in next, Players:GetPlayers() do
            Highlight(v)
        end

        Players.PlayerRemoving:Connect(function(plr)
            local plrname = plr.Name
            if Storage[plrname] then
                Storage[plrname]:Destroy()
            end
            if connections[plr] then
                connections[plr]:Disconnect()
            end
        end)
    end
})
end



-- Proximity Prompt Toggle Script
local ProximityPromptService = game:GetService("ProximityPromptService")
local proximityConnection -- To store the connection

-- Function to enable/disable Proximity Prompt interactions
local function toggleProximityPrompt(enable)
    if enable then
        -- Connect to the event if enabled
        proximityConnection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)
    elseif proximityConnection then
        -- Disconnect the event if it was connected
        proximityConnection:Disconnect()
        proximityConnection = nil -- Reset the variable after disconnecting
    end
end

-- Toggle for Proximity Prompt in the UI
local ToggleProximity = Tabs.MAIN:AddToggle("ProximityPromptToggle", {Title = "Toggle Instance Proximity Prompt", Default = false})

-- Handle the toggle state change
ToggleProximity:OnChanged(function()
    local isProximityOn = ToggleProximity.Value
    toggleProximityPrompt(isProximityOn)
end)


-- Initialize variables
local fullbrightEnabled = false
local lighting = game:GetService("Lighting")
local originalSettings = {
    Brightness = lighting.Brightness,
    ClockTime = lighting.ClockTime,
    Ambient = lighting.Ambient,
    OutdoorAmbient = lighting.OutdoorAmbient,
}

-- Function to enable Fullbright
local function enableFullbright()
    lighting.Brightness = 2
    lighting.ClockTime = 14 -- Set to daytime
    lighting.Ambient = Color3.new(1, 1, 1)
    lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end

-- Function to disable Fullbright
local function disableFullbright()
    lighting.Brightness = originalSettings.Brightness
    lighting.ClockTime = originalSettings.ClockTime
    lighting.Ambient = originalSettings.Ambient
    lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
end

-- Add toggle to the UI
local Toggle = Tabs.MAIN:AddToggle("FullbrightToggle", { Title = "Enable Fullbright", Default = false })

-- Handle toggle state changes
Toggle:OnChanged(function()
    fullbrightEnabled = Toggle.Value
    

    if fullbrightEnabled then
        enableFullbright()
    else
        disableFullbright()
    end
end)








Tabs.MAIN:AddSection("Player Misc")  




-- Initialize variables
local noclipEnabled = false

-- Function to toggle noclip
local function toggleNoclip(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if state then
        game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled then
                for _, v in pairs(character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end

-- Add toggle to the UI
local Toggle = Tabs.MAIN:AddToggle("NoclipToggle", { Title = "Noclip", Default = false })

-- Handle toggle state changes
Toggle:OnChanged(function()
    noclipEnabled = Toggle.Value
    toggleNoclip(noclipEnabled)
end)











-- Player Speed Toggle and Slider

-- Variables
local speedEnabled = false
local desiredSpeed = 16 -- Default Roblox speed
local player = game.Players.LocalPlayer

-- Function to set player speed
local function setSpeed(speed)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

-- Function to ensure speed persists
local function monitorSpeed()
    while speedEnabled do
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.WalkSpeed ~= desiredSpeed then
                setSpeed(desiredSpeed)
            end
        end
        task.wait(0.1)
    end
end

-- Toggle to enable/disable speed control
local SpeedToggle = Tabs.MAIN:AddToggle("SpeedToggle", { Title = "Enable Speed Control", Default = false })

SpeedToggle:OnChanged(function()
    speedEnabled = SpeedToggle.Value

    if speedEnabled then
        task.spawn(monitorSpeed)
    end
end)

-- Slider to adjust speed
local SpeedSlider = Tabs.MAIN:AddSlider("SpeedSlider", {
    Title = "Player Speed",
    Description = "Adjust your walk speed",
    Default = 16,
    Min = 10,
    Max = 120, -- Maximum speed set to 120
    Rounding = 0,
    Callback = function(Value)
        desiredSpeed = Value
        if speedEnabled then
            setSpeed(desiredSpeed)
        end
    end,
})

SpeedSlider:SetValue(16) -- Set the initial slider value

-- Monitor respawn to ensure speed persists
player.CharacterAdded:Connect(function(character)
    if speedEnabled then
        repeat task.wait() until character:FindFirstChild("Humanoid")
        setSpeed(desiredSpeed)
    end
end)




   
   
   
   
-- Toggle for Jump Power
   local ToggleJump = Tabs.MAIN:AddToggle("JumpToggle", {Title = "Toggle Jump Power", Default = false })
   
   ToggleJump:OnChanged(function()
   local jumpEnabled = Options.JumpToggle.Value
   if not jumpEnabled then
   game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50 -- reset to default jump power
   end
   end)
   
   -- Jump Power Slider
   local SliderJump = Tabs.MAIN:AddSlider("JumpPowerSlider", {
   Title = "Jump Power",
   Description = "Adjust your jump power",
   Default = 50,
   Min = 1, -- Default jump power
   Max = 200, -- Maximum jump power
   Rounding = 0,
   Callback = function(Value)
   if Options.JumpToggle.Value then
   game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end
   end
   })
   
   SliderJump:SetValue(50) -- Set default jump power
   
   
   
   
   Tabs.B1C1:AddSection("Part 1")  
   
   Tabs.B1C1:AddButton({
           Title = "Auto Win",
           Description = "Self Explained",
           Callback = function()
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3445.80493, 37.6461182, -1542.26685, -0.0656819865, -7.81556366e-08, 0.997840583, 7.02771246e-08, 1, 8.29507059e-08, -0.997840583, 7.55737375e-08, -0.0656819865)
            end
         })   
           
    Tabs.B1C1:AddSection("Part 2")  
           
           
                 
   Tabs.B1C1:AddButton({
           Title = "Auto Win",
           Description = "Self Explained",
           Callback = function()
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1261.78845, 199.540009, -2536.78955, 0.495596468, -2.43472673e-08, 0.868552923, 6.15256912e-09, 1, 2.45213343e-08, -0.868552923, -6.80885437e-09, 0.495596468)
            end
         })                 
           
     
     
     
      Tabs.B1C2:AddSection("Part 1")  
            
           
           
      Tabs.B1C2:AddButton({
           Title = "Auto Win",
           Description = "Self Explained",
           Callback = function()
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(65.1952972, 56.6845131, -1588.85229, -0.877218008, 0, 0.480092257, 0, 1, 0, -0.480092257, 0, -0.877218008)
            end
         })      
           
           
         
   Tabs.B1C2:AddSection("Part 2")   
           
           
           
           
           
   
   Tabs.B1C2:AddButton({   
            Title = "Auto Win",
           Description = "Self Explained",
           Callback = function()
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(234.335876, 101.941422, -561.392883, 0.98569411, 2.45511398e-08, -0.168544099, -1.58307909e-08, 1, 5.3082978e-08, 0.168544099, -4.96553909e-08, 0.98569411)
            end 
         })           
         
         
         
         
         
         
           
           
           
           
           
           
   Tabs.B1C2:AddSection("Part 3")    
           
           
           
           
           
   
   -- Create a notification function
   local function Notify(title, text, duration)
       local StarterGui = game:GetService("StarterGui")
       StarterGui:SetCore("SendNotification", {
           Title = title;
           Text = text;
           Duration = duration;
       })
   end
   
   Tabs.B1C2:AddButton({
       Title = "Auto Win",
       Description = "Self Explained",
       Callback = function()
           -- First teleport immediately
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(859.177307, 72.9999924, -355.12088, -0.0317773335, 0, -0.99949497, 0, 1, 0, 0.99949497, 0, -0.0317773335)
   
           -- Show notification immediately
           Notify("Auto Win", "Walk straight and wait for 3-5 seconds", 5)
   
           -- Wait for 5 seconds before the second teleport
           task.wait(5)
   
           -- Second teleport after 5 seconds
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1046.68091, 77.1533279, -355.660278, -0.312641442, 6.93475777e-10, -0.949871182, 6.23868734e-10, 1, 5.24732702e-10, 0.949871182, -4.28541758e-10, -0.312641472)
       end 
   })  
         
         
   
   
   
   
    Tabs.Cre:AddSection("Credits")
   
      
      Tabs.Cre:AddParagraph({
           Title = "ChatGPT",
           Content = "Toggle-able Fullbright, Toggle-able Instance Proximity Prompt, WalkSpeed, JumpPower"
       })
         
         
      
      Tabs.Cre:AddParagraph({
            Title = "Me",
            Content = "Almost Everything, My discord is floppapan9287"
       })
       
       
       -- 65.1952972, 56.6845131, -1588.85229, -0.877218008, 0, 0.480092257, 0, 1, 0, -0.480092257, 0, -0.877218008
       
       
      
   
     
  
         
       
       
       
