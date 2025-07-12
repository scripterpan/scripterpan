local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Universal",
    Icon = "door-open",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi",
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
    Title = "Pann Universal",
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


local Uni = Window:Tab({
    Title = "Universal Script",
    Icon = "scroll-text",
    Locked = false,
})

local Player = Window:Tab({
    Title = "Player",
    Icon = "users",
    Locked = false,
})

local Aim = Window:Tab({
    Title = "Aimbot",
    Icon = "crosshair",
    Locked = false,
})

local ESP = Window:Tab({
    Title = "ESP",
    Icon = "eye",
    Locked = false,
})


local Other = Window:Tab({
    Title = "Other",
    Icon = "badge-plus",
    Locked = false,
})


local Button = Uni:Button({
    Title = "Infinite Yield",
    Desc = "Best fe command script",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
    end
})
    


local Button = Uni:Button({
    Title = "Fly GUI",
    Desc = "Best Fly Script",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end
})
    




local Button = Uni:Button({
    Title = "Dex V4",
    Desc = "Dark Dex V4 Mobile (No key) Credits to Yume Hub",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Artifacttx/YumeHub/refs/heads/main/Universal/DarkDex_Mobile", true))()
    end
})
    


local Button = Uni:Button({
    Title = "Owl Hub",
    Desc = "Support a lot of roblox FPS game like arsenal",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
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
local Toggle = Player:Toggle({
    Title = "Noclip",
    Desc = "Noclip Yes 👍",
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


-- Player Spped, Jumppower, Gravity 
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- State
local speedEnabled = false
local jumpEnabled = false
local gravityEnabled = false

-- Default values
local defaultSpeed = 16
local defaultJumpPower = 50
local defaultGravity = 196.2

-- Desired values
local desiredSpeed = defaultSpeed
local desiredJumpPower = defaultJumpPower
local desiredGravity = defaultGravity

-- Apply Functions
local function setSpeed(speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

local function setJumpPower(power)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local hum = player.Character:FindFirstChild("Humanoid")
        hum.UseJumpPower = true
        hum.JumpPower = power
    end
end

local function setGravity(g)
    workspace.Gravity = g
end

-- Reapply on respawn
player.CharacterAdded:Connect(function()
    repeat task.wait() until player.Character:FindFirstChild("Humanoid")
    if speedEnabled then setSpeed(desiredSpeed) end
    if jumpEnabled then setJumpPower(desiredJumpPower) end
    if gravityEnabled then setGravity(desiredGravity) end
end)

-- UI Element references
local SpeedSlider, SpeedInput
local JumpSlider, JumpInput
local GravitySlider, GravityInput

-- SPEED TOGGLE
local SpeedToggle = Player:Toggle({
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
SpeedSlider = Player:Slider({
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
SpeedInput = Player:Input({
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

-- JUMP TOGGLE
local JumpToggle = Player:Toggle({
    Title = "Jump Boost",
    Desc = "Enable jump boost",
    Icon = "person-standing",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        jumpEnabled = state
        if state then
            setJumpPower(desiredJumpPower)
            task.spawn(function()
                while jumpEnabled do
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        if player.Character.Humanoid.JumpPower ~= desiredJumpPower then
                            setJumpPower(desiredJumpPower)
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            setJumpPower(defaultJumpPower)
        end
    end
})

-- JUMP SLIDER
JumpSlider = Player:Slider({
    Title = "Jump Power",
    Step = 1,
    Value = {
        Min = 1,
        Max = 500,
        Default = defaultJumpPower,
    },
    Callback = function(val)
        desiredJumpPower = val
        if JumpInput and JumpInput.SetValue then
            JumpInput:SetValue(tostring(val))
        end
        if jumpEnabled then
            setJumpPower(desiredJumpPower)
        end
    end
})

-- JUMP INPUT
JumpInput = Player:Input({
    Title = "Set Jump Power",
    Desc = "Type jump power value\nif you're lazy to use the slider (1–500)",
    Placeholder = tostring(defaultJumpPower),
    InputIcon = "person-standing",
    Type = "Input",
    Value = tostring(desiredJumpPower),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 500 then
            desiredJumpPower = num
            if JumpSlider and JumpSlider.Set then
                JumpSlider:Set(num)
            end
            if jumpEnabled then
                setJumpPower(desiredJumpPower)
            end
        end
    end
})

-- GRAVITY TOGGLE
local GravityToggle = Player:Toggle({
    Title = "Change Gravity",
    Desc = "Enable gravity override",
    Icon = "clock-arrow-down",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        gravityEnabled = state
        if state then
            setGravity(desiredGravity)
            task.spawn(function()
                while gravityEnabled do
                    if workspace.Gravity ~= desiredGravity then
                        setGravity(desiredGravity)
                    end
                    task.wait(0.1)
                end
            end)
        else
            setGravity(defaultGravity)
        end
    end
})

-- GRAVITY SLIDER
GravitySlider = Player:Slider({
    Title = "Gravity Value",
    Step = 1,
    Value = {
        Min = 0,
        Max = 500,
        Default = defaultGravity,
    },
    Callback = function(val)
        desiredGravity = val
        if GravityInput and GravityInput.SetValue then
            GravityInput:SetValue(tostring(val))
        end
        if gravityEnabled then
            setGravity(desiredGravity)
        end
    end
})

-- GRAVITY INPUT
GravityInput = Player:Input({
    Title = "Set Gravity",
    Desc = "Type gravity value\nif you're lazy to use the slider (0–500)",
    Placeholder = tostring(defaultGravity),
    InputIcon = "clock-arrow-down",
    Type = "Input",
    Value = tostring(desiredGravity),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 0 and num <= 500 then
            desiredGravity = num
            if GravitySlider and GravitySlider.Set then
                GravitySlider:Set(num)
            end
            if gravityEnabled then
                setGravity(desiredGravity)
            end
        end
    end
})











    

-- ESP 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local espConnections = {} -- store connections for cleanup
local selectedColor = Color3.fromRGB(255, 255, 0) -- Default: Yellow

local Dropdown = ESP:Dropdown({
    Title = "ESP Color",
    Values = { "Red", "Green", "Blue", "Yellow", "Purple", "White" },
    Value = "Yellow",
    Callback = function(option)
        local colorMap = {
            Red = Color3.fromRGB(255, 0, 0),
            Green = Color3.fromRGB(0, 255, 0),
            Blue = Color3.fromRGB(0, 0, 255),
            Yellow = Color3.fromRGB(255, 255, 0),
            Purple = Color3.fromRGB(150, 0, 255),
            White = Color3.fromRGB(255, 255, 255),
        }

        selectedColor = colorMap[option] or Color3.fromRGB(255, 255, 0)
    end
})




local Toggle = ESP:Toggle({
    Title = "Player ESP",
    Desc = "Yea",
    Icon = "users",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        -- Helper: Apply ESP to a character model
        local function applyESP(model)
            if not model then return end

            if model:FindFirstChild("ESP_Highlight") then model.ESP_Highlight:Destroy() end
            if model:FindFirstChild("ESP_NameTag") then model.ESP_NameTag:Destroy() end

            local h = Instance.new("Highlight")
            h.Name = "ESP_Highlight"
            h.FillColor = selectedColor
            h.OutlineColor = Color3.fromRGB(255, 255, 255)
            h.FillTransparency = 0.5
            h.OutlineTransparency = 0
            h.Adornee = model
            h.Parent = model

            local nameTag = Instance.new("BillboardGui")
            nameTag.Name = "ESP_NameTag"
            nameTag.Adornee = model
            nameTag.Size = UDim2.new(0, 100, 0, 50)
            nameTag.StudsOffset = Vector3.new(0, 3, 0)
            nameTag.AlwaysOnTop = true

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = model.Name
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextStrokeTransparency = 0.5
            label.TextSize = 14
            label.Parent = nameTag

            nameTag.Parent = model
        end

        -- Remove ESP from character
        local function removeESP(model)
            if not model then return end
            if model:FindFirstChild("ESP_Highlight") then model.ESP_Highlight:Destroy() end
            if model:FindFirstChild("ESP_NameTag") then model.ESP_NameTag:Destroy() end
        end

        -- Apply to all current players
        local function updateAll()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    if state then
                        applyESP(plr.Character)
                    else
                        removeESP(plr.Character)
                    end
                end
            end
        end

        -- Disconnect previous connections if toggled off
        for _, conn in ipairs(espConnections) do
            conn:Disconnect()
        end
        table.clear(espConnections)

        updateAll()

        if state then
            -- Connect to future spawns for existing players
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local conn = plr.CharacterAdded:Connect(function(char)
                        task.wait(1)
                        applyESP(char)
                    end)
                    table.insert(espConnections, conn)
                end
            end

            -- Connect to new players
            local conn = Players.PlayerAdded:Connect(function(plr)
                if plr ~= LocalPlayer then
                    local spawnConn = plr.CharacterAdded:Connect(function(char)
                        task.wait(1)
                        applyESP(char)
                    end)
                    table.insert(espConnections, spawnConn)
                end
            end)
            table.insert(espConnections, conn)
        end
    end
})

-- FullBright 
local lighting = game:GetService("Lighting")

-- Save original settings
local originalSettings = {
    Brightness = lighting.Brightness,
    ClockTime = lighting.ClockTime,
    Ambient = lighting.Ambient,
    OutdoorAmbient = lighting.OutdoorAmbient,
}

-- Enable/disable functions
local function enableFullbright()
    lighting.Brightness = 2
    lighting.ClockTime = 14
    lighting.Ambient = Color3.new(1, 1, 1)
    lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end

local function disableFullbright()
    lighting.Brightness = originalSettings.Brightness
    lighting.ClockTime = originalSettings.ClockTime
    lighting.Ambient = originalSettings.Ambient
    lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
end

-- WindUI Toggle
local Toggle = Other:Toggle({
    Title = "Fullbright",
    Desc = "Brightness Yes 👍",
    Icon = "sun",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        if val then
            enableFullbright()
        else
            disableFullbright()
        end
    end
})






local ProximityPromptService = game:GetService("ProximityPromptService")
local proximityConnection
local promptAddedConnection
local modifiedPrompts = {} -- Track modified prompts and their original settings

-- Make the prompt instant (no delay, no hold animation)
local function makePromptInstant(prompt)
    -- Store original values once
    if not modifiedPrompts[prompt] then
        modifiedPrompts[prompt] = {
            HoldDuration = prompt.HoldDuration,
            RequiresLineOfSight = prompt.RequiresLineOfSight,
            ClickablePrompt = prompt.ClickablePrompt
        }
    end

    prompt.HoldDuration = 0
    prompt.RequiresLineOfSight = false
    prompt.ClickablePrompt = true
end

-- Restore original prompt settings
local function restorePrompt(prompt)
    local original = modifiedPrompts[prompt]
    if original then
        prompt.HoldDuration = original.HoldDuration
        prompt.RequiresLineOfSight = original.RequiresLineOfSight
        prompt.ClickablePrompt = original.ClickablePrompt
        modifiedPrompts[prompt] = nil
    end
end

-- Turn on/off Instant Interact
local function toggleInstantInteract(enabled)
    if enabled then
        -- Update all existing prompts
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                makePromptInstant(obj)
            end
        end

        -- Fire prompt instantly when hold begins
        proximityConnection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)

        -- Make new prompts instant too
        promptAddedConnection = game.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                makePromptInstant(obj)
            end
        end)
    else
        -- Disconnect events
        if proximityConnection then
            proximityConnection:Disconnect()
            proximityConnection = nil
        end
        if promptAddedConnection then
            promptAddedConnection:Disconnect()
            promptAddedConnection = nil
        end

        -- Restore all modified prompts
        for prompt, _ in pairs(modifiedPrompts) do
            restorePrompt(prompt)
        end
    end
end

-- WindUI Toggle
local Toggle = Other:Toggle({
    Title = "Instant Interact",
    Desc = "ok",
    Icon = "hand",
    Type = "Toggle", -- Checkbox Or toggle Mango
    Default = false,
    Callback = function(state)
        toggleInstantInteract(state)
    end
})
