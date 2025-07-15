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
    User = {
        Enabled = true,
        Anonymous = false,
    }
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

local misc = Window:Tab({
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


local Toggle = misc:Toggle({
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


local Toggle = misc:Toggle({
    Title = "ESP Monster",
    Desc = "See where the monster is",
    Icon = "eye",
    Type = "Toggle",
    Default = false,
    Callback = function(val) 
        monsterESPEnabled = val
    end
})







local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local noclipConnection
local originalCollisions = {}

-- Save original collision states
local function saveOriginalCollisions()
    originalCollisions = {}
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalCollisions[part] = part.CanCollide
            end
        end
    end
end

-- Apply noclip (no collisions)
local function startNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
    end

    saveOriginalCollisions()

    noclipConnection = RunService.Stepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- Restore original collision
local function stopNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    for part, canCollide in pairs(originalCollisions) do
        if part and part:IsA("BasePart") then
            part.CanCollide = canCollide
        end
    end
    originalCollisions = {}
end

-- WindUI Toggle
local Toggle = misc:Toggle({
    Title = "Noclip",
    Desc = "Walk Through The Wall",
    Icon = "expand",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            startNoclip()
        else
            stopNoclip()
        end
    end
})

-- Handle respawn
LocalPlayer.CharacterAdded:Connect(function()
    repeat task.wait() until LocalPlayer.Character:FindFirstChild("Humanoid")
    saveOriginalCollisions()
    if Toggle.Value then
        startNoclip()
    end
end)







local Players = game:GetService("Players")
local player = Players.LocalPlayer


local defaultSpeed = 16
local desiredSpeed = defaultSpeed

local function setSpeed(speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

player.CharacterAdded:Connect(function()
    repeat task.wait() until player.Character:FindFirstChild("Humanoid")
    if speedEnabled then setSpeed(desiredSpeed) end
    if jumpEnabled then setJumpPower(desiredJumpPower) end
    if gravityEnabled then setGravity(desiredGravity) end
end)

local SpeedSlider, SpeedInput

local SpeedToggle = misc:Toggle({
    Title = "Speed Boost",
    Desc = "Enable speed boost",
    Icon = "chevrons-up",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        speedEnabled = state
        if state then
            setSpeed(desiredSpeed)
            task.spawn(function()
                while speedEnabled do
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        if player.Character.Humanoid.WalkSpeed ~= desiredSpeed then
                            setSpeed(desiredSpeed)
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            setSpeed(defaultSpeed)
        end
    end
})

-- SPEED SLIDER
SpeedSlider = misc:Slider({
    Title = "Walk Speed",
    Step = 1,
    Value = {
        Min = 1,
        Max = 500,
        Default = defaultSpeed,
    },
    Callback = function(val)
        desiredSpeed = val
        if SpeedInput and SpeedInput.SetValue then
            SpeedInput:SetValue(tostring(val))
        end
        if speedEnabled then
            setSpeed(desiredSpeed)
        end
    end
})

-- SPEED INPUT
SpeedInput = misc:Input({
    Title = "Set Walk Speed",
    Desc = "Type your speed value here\nif you're lazy to use the slider (1–500)",
    Placeholder = tostring(defaultSpeed),
    InputIcon = "chevrons-up",
    Type = "Input",
    Value = tostring(desiredSpeed),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 500 then
            desiredSpeed = num
            if SpeedSlider and SpeedSlider.Set then
                SpeedSlider:Set(num)
            end
            if speedEnabled then
                setSpeed(desiredSpeed)
            end
        end
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
