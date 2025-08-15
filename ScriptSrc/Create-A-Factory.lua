local url = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
local ok, body = pcall(function() return game:HttpGet(url) end)
if not ok or not body or body == "" then
    warn("HttpGet failed:", body)
    return
end

local f, err = loadstring(body)
if not f then
    warn("loadstring failed:", err)
    return
end

local WindUI = f()
if type(WindUI) ~= "table" then
    warn("WindUI loader returned nil or wrong type")
    return
end


local Window = WindUI:CreateWindow({
    Title = "Create A Factory",
    Icon = "cat",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi-CreateAFactory",
    Size = UDim2.fromOffset(520, 360),
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
    Title = "Pann Hub (Create A Factory)",
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

Tabs.stat = Window:Section({
        Title = "Status",
        Opened = true,
    })
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

    
    Tabs.StatPlayer = Tabs.stat:Tab({ Title = "Player's Status", Icon = "speech" })
    Tabs.StatServer = Tabs.stat:Tab({ Title = "Server's Status", Icon = "server" })
    Tabs.main1 = Tabs.main:Tab({ Title = "Cool Things", Icon = "album" })
    Tabs.gemisc = Tabs.misc:Tab({ Title = "Misc", Icon = "tv-minimal"})
    Tabs.plmisc = Tabs.misc:Tab({ Title = "Local Player", Icon = "person-standing"})
    Tabs.src = Tabs.Other:Tab({ Title = "Universal Script & Tools", Icon = "scroll-text" })
    
end



-- setup function for teleport 
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")







-- setup for show ping and fps
local Stats = game:GetService("Stats")
local network = Stats:FindFirstChild("Network")
local RunService = game:GetService("RunService")



-- setup for something important
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- AntiAFK
local vu = game:GetService("VirtualUser")



-- lighting
local lighting = game:GetService("Lighting")


-- instant interact
local ProximityPromptService = game:GetService("ProximityPromptService")
local proximityConnection
local promptAddedConnection
local modifiedPrompts = {}


Tabs.StatPlayer:Section({ Title = "Player Status", Icon = "speech" })


Tabs.StatPlayer:Paragraph({
    Title = "Your Executor",
    Desc = identifyexecutor(),
    Locked = false,
})


local paragraph = Tabs.StatPlayer:Paragraph({
    Title = "Your Ping",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        local ping = nil
        pcall(function()
            local serverStats = network and network:FindFirstChild("ServerStatsItem")
            local dataPing = serverStats and serverStats:FindFirstChild("Data Ping")
            if dataPing then
                ping = dataPing:GetValue()
            end
        end)

        if ping then
            paragraph:SetDesc("Ping: " .. string.format("%.2f", ping) .. " ms")
        else
            paragraph:SetDesc("Ping: N/A")
        end

        task.wait(1)
    end
end)


local paragraph = Tabs.StatPlayer:Paragraph({
    Title = "Your FPS",
    Desc = "Loading...",
    Locked = false,
})

local fps = 60
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = now
    end
end)

task.spawn(function()
    while true do
        paragraph:SetDesc("FPS: " .. tostring(fps))
        task.wait(1)
    end
end)


Tabs.StatServer:Section({ Title = "Server Status", Icon = "server" })



local paragraph = Tabs.StatServer:Paragraph({
    Title = "Server Ping",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        local ping = player:GetNetworkPing() * 1000 -- Convert to milliseconds
        paragraph:SetDesc("Current Server Ping : " .. string.format("%.2f", ping) .. " ms")
        task.wait(1)
    end
end)



local paragraph = Tabs.StatServer:Paragraph({
    Title = "Player Count",
    Desc = "Loading...",
    Locked = false,
})

task.spawn(function()
    while true do
        paragraph:SetDesc("Players in Server: " .. tostring(#Players:GetPlayers()))
        task.wait(0.25)
    end
end)




Tabs.main1:Section({ Title = "Main Things", Icon = "wrench" })

Tabs.main1:Toggle({
    Title = "Get Money Infinitely",
    Desc = "1T Per second I guess",
    Icon = "moon",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.GetMoney = val

        task.spawn(function()
            while _G.GetMoney do
                local sellerBases = {"Base1", "Base2", "Base3"}
                for _, baseName in ipairs(sellerBases) do
                    local base = workspace:FindFirstChild(baseName)
                    if base and base:FindFirstChild("PlacedPieces") and base.PlacedPieces:FindFirstChild("Seller") then
                        local args = {
                            base.PlacedPieces.Seller,
                            500000000000
                        }
                        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("SetupConveyorTouches")
                        if remote then
                            remote:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.1) -- small delay so it keeps firing without being blocked
                end
            end
        end)
    end
})



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuyMoonItem = ReplicatedStorage:WaitForChild("BuyMoonItem")
local GiveMoonCoin = ReplicatedStorage:WaitForChild("GiveMoonCoin")

local items = {
    "StraightConveyor",
    "LeftConveyor",
    "RightConveyor",
    "RGBMachine",
    "Polisher",
    "Freezer",
    "Goldifier",
    "Soaker",
    "MossMachine",
    "Rainbowifier",
    "VoidMachine",
    "DarkmatterMachine",
    "Duplicator",
    "CosmicMachine",
    "BlackHoleMachine",
    "CometMachine"
}

local selectedItem = nil


Tabs.main1:Dropdown({
    Title = "Select Conveyor",
    Values = items,
    Multi = false,
    AllowNone = false,
    Callback = function(item)
        selectedItem = item
    end
})


Tabs.main1:Button({
    Title = "Get Selected Conveyor",
    Desc = "Gets the conveyor you selected above (It got a delay for like 2 seconds before you can get the selected conveyor again)",
    Locked = false,
    Callback = function()
        if selectedItem then
            BuyMoonItem:FireServer(1, selectedItem)
        else
            WindUI:Notify({
                Title = "No Selection",
                Content = "Please select a conveyor first!",
                Duration = 3,
                Icon = "monitor-cog",
            })
        end
    end
})






Tabs.main1:Section({ Title = "Cosmic Event", Icon = "moon" })

Tabs.main1:Toggle({
    Title = "Get Moon Coins",
    Desc = "Get moon coins infinitely",
    Icon = "moon",
    Type = "Toggle",
    Default = false,
    Callback = function(val)
        _G.GetMoon = val
        
        task.spawn(function()
            while _G.GetMoon do
                game:GetService("ReplicatedStorage"):WaitForChild("GiveMoonCoin"):FireServer()
                game:GetService("ReplicatedStorage"):WaitForChild("GiveMoonCoin"):FireServer()
                task.wait()
            end
        end)
    end
})

Tabs.gemisc:Section({ Title = "Misc Things", Icon = "wrench" })

local connection

Tabs.gemisc:Toggle({
    Title = "AntiAFK",
    Desc = "Prevents you from getting kicked for being idle",
    Icon = "shield-ban",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if connection then
            connection:Disconnect()
            connection = nil
        end

        if state then
            connection = player.Idled:Connect(function()
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end)
        end
    end
})


local function makePromptInstant(prompt)
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

local function restorePrompt(prompt)
    local original = modifiedPrompts[prompt]
    if original then
        prompt.HoldDuration = original.HoldDuration
        prompt.RequiresLineOfSight = original.RequiresLineOfSight
        prompt.ClickablePrompt = original.ClickablePrompt
        modifiedPrompts[prompt] = nil
    end
end

local function toggleInstantInteract(enabled)
    if enabled then
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                makePromptInstant(obj)
            end
        end  
        
        proximityConnection = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)

        promptAddedConnection = game.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                makePromptInstant(obj)
            end
        end)
    else

        if proximityConnection then
            proximityConnection:Disconnect()
            proximityConnection = nil
        end
        if promptAddedConnection then
            promptAddedConnection:Disconnect()
            promptAddedConnection = nil
        end

        for prompt, _ in pairs(modifiedPrompts) do
            restorePrompt(prompt)
        end
    end
end


Tabs.gemisc:Toggle({
    Title = "Instant Interact",
    Desc = "Interact with anything without a cooldown",
    Icon = "hand",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        toggleInstantInteract(state)
    end
})

Tabs.gemisc:Button({
    Title = "Rejoin",
    Desc = "Rejoin the same game, same server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})


Tabs.gemisc:Section({ Title = "Visual", Icon = "binoculars" })

-- FullBright 
local originalSettings = {
    Brightness = lighting.Brightness,
    ClockTime = lighting.ClockTime,
    Ambient = lighting.Ambient,
    OutdoorAmbient = lighting.OutdoorAmbient,
}

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

Tabs.gemisc:Toggle({
    Title = "Fullbright",
    Desc = "Increase Brightness",
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

Tabs.gemisc:Section({ Title = "GPU Care", Icon = "cpu" })

local whiteScreen

Tabs.gemisc:Toggle({
    Title = "White Screen",
    Desc = "Self-explanatory",
    Icon = "cpu",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            whiteScreen = Instance.new("ScreenGui", game:GetService("CoreGui"))
            whiteScreen.IgnoreGuiInset = true
            whiteScreen.Name = "WhiteScreenOverlay"

            local frame = Instance.new("Frame", whiteScreen)
            frame.BackgroundColor3 = Color3.new(1, 1, 1)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.Position = UDim2.new(0, 0, 0, 0)
        else
            if whiteScreen then
                whiteScreen:Destroy()
                whiteScreen = nil
            end
        end
    end
})

local blackScreen

Tabs.gemisc:Toggle({
    Title = "Black Screen",
    Desc = "Self-explanatory",
    Icon = "cpu",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            blackScreen = Instance.new("ScreenGui", game:GetService("CoreGui"))
            blackScreen.IgnoreGuiInset = true
            blackScreen.Name = "BlackScreenOverlay"

            local frame = Instance.new("Frame", blackScreen)
            frame.BackgroundColor3 = Color3.new(0, 0, 0)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.Position = UDim2.new(0, 0, 0, 0)
        else
            if blackScreen then
                blackScreen:Destroy()
                blackScreen = nil
            end
        end
    end
})


Tabs.plmisc:Section({ Title = "Players", Icon = "person-standing" })


local infiniteJumpEnabled = false
local humanoid = nil
local conn = nil

local function enableInfiniteJump()
    if conn then conn:Disconnect() end
    conn = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infiniteJumpEnabled and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function setupCharacter(char)
    humanoid = char:WaitForChild("Humanoid", 5)
    if infiniteJumpEnabled then
        enableInfiniteJump()
    end
end

player.CharacterAdded:Connect(function(char)
    setupCharacter(char)
end)

if player.Character then
    setupCharacter(player.Character)
end

Tabs.plmisc:Toggle({
    Title = "Infinite Jump",
    Desc = "Toggle Infinite Jump",
    Icon = "arrow-big-up-dash",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
        if state then
            if player.Character then
                setupCharacter(player.Character)
            end
        else
            if conn then conn:Disconnect() end
        end
    end
})



local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local noclipConnection
local originalCollisions = {}


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


Tabs.plmisc:Toggle({
    Title = "Noclip",
    Desc = "Walk Through Objects",
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

LocalPlayer.CharacterAdded:Connect(function()
    repeat task.wait() until LocalPlayer.Character:FindFirstChild("Humanoid")
    saveOriginalCollisions()
    if Toggle.Value then
        startNoclip()
    end
end)




local speedEnabled = false
local jumpEnabled = false
local gravityEnabled = false


local defaultSpeed = 16
local defaultJumpPower = 50
local defaultGravity = 196.2


local desiredSpeed = defaultSpeed
local desiredJumpPower = defaultJumpPower
local desiredGravity = defaultGravity


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


player.CharacterAdded:Connect(function()
    repeat task.wait() until player.Character:FindFirstChild("Humanoid")
    if speedEnabled then setSpeed(desiredSpeed) end
    if jumpEnabled then setJumpPower(desiredJumpPower) end
    if gravityEnabled then setGravity(desiredGravity) end
end)


local SpeedInput
local JumpInput
local GravityInput

-- speed
Tabs.plmisc:Section({ Title = "Speed", Icon = "zap" })


Tabs.plmisc:Toggle({
    Title = "Speed Boost",
    Desc = "Enable speed boost",
    Icon = "zap",
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

Tabs.plmisc:Input({
    Title = "Set Walk Speed",
    Desc = "Type your speed value here (1–500)",
    Placeholder = tostring(defaultSpeed),
    InputIcon = "chevrons-up",
    Type = "Input",
    Value = tostring(desiredSpeed),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 500 then
            desiredSpeed = num
            if speedEnabled then
                setSpeed(desiredSpeed)
            end
        end
    end
})

-- Jumppower
Tabs.plmisc:Section({ Title = "Jump Power", Icon = "person-standing" })

Tabs.plmisc:Toggle({
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

Tabs.plmisc:Input({
    Title = "Set Jump Power",
    Desc = "Type jump power value (1–500)",
    Placeholder = tostring(defaultJumpPower),
    InputIcon = "person-standing",
    Type = "Input",
    Value = tostring(desiredJumpPower),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 1 and num <= 500 then
            desiredJumpPower = num
            if jumpEnabled then
                setJumpPower(desiredJumpPower)
            end
        end
    end
})


-- Gravity 
Tabs.plmisc:Section({ Title = "Gravity", Icon = "clock-arrow-down" })

Tabs.plmisc:Toggle({
    Title = "Change Gravity",
    Desc = "Enable gravity changer",
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

Tabs.plmisc:Input({
    Title = "Set Gravity",
    Desc = "Type gravity value (0–500)",
    Placeholder = tostring(defaultGravity),
    InputIcon = "clock-arrow-down",
    Type = "Input",
    Value = tostring(desiredGravity),
    Callback = function(input)
        local num = tonumber(input)
        if num and num >= 0 and num <= 500 then
            desiredGravity = num
            if gravityEnabled then
                setGravity(desiredGravity)
            end
        end
    end
})




Tabs.src:Section({ Title = "Universal Scripts", Icon = "usb" })


Tabs.src:Button({
    Title = "Infinite Yield",
    Desc = "Best command script",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
    end
})
    


Tabs.src:Button({
    Title = "Fly GUI V3",
    Desc = "Best Fly Script",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end
})
    




Tabs.src:Button({
    Title = "Dex V4",
    Desc = "Dark Dex V4 Mobile \nGood for scripting",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end
})

Tabs.src:Button({
    Title = "Dex++",
    Desc = "Since the original Dex is the last release and Moon have discontinued it, it still has some missing features",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
    end
})

Tabs.src:Section({ Title = "Tools", Icon = "gavel" })

Tabs.src:Button({
    Title = "Simple SPY",
    Desc = "Best script for logging remote that happened in game \nYour executor must support : \n- hookmetamethod\n- getnamecallmethod\n- setnamecallmethod\n- newcclosure\n- getrawmetatable\n- setreadonly",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/Tools/Mobile-Simple-Spy.lua"))()
    end
})

Tabs.src:Button({
    Title = "BTools",
    Desc = "let you destroy, copy things in the game (Visual, only appear to yourself)",
    Locked = false,
    Callback = function()
        backpack = game:GetService("Players").LocalPlayer.Backpack
            
        hammer = Instance.new("HopperBin")
        hammer.Name = "Hammer"
        hammer.BinType = 4
        hammer.Parent = backpack

        cloneTool = Instance.new("HopperBin")
        cloneTool.Name = "Clone"
        cloneTool.BinType = 3
        cloneTool.Parent = backpack

        grabTool = Instance.new("HopperBin")
        grabTool.Name = "Grab"
        grabTool.BinType = 2
        grabTool.Parent = backpack

        WindUI:Notify({
            Title = "Notification",
            Content = "BTools has been added to your inventory, please check you inventory",
            Icon = "circle-alert",
            Duration = 5,
        })
    end
})
