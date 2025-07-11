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
