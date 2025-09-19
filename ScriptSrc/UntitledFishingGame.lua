local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Untitled Fishing Game",
    Icon = "fish",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi-fishing",
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
    Title = "Pann Hub (Untitled Fishing Game)",
    Icon = "fish",
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

    Tabs.main = Window:Section({
        Title = "Main",
        Opened = true,
    })

  Tabs.fish = Tabs.main:Tab({ Title = "Fishing", Icon = "fish" })

end

local fishingEnabled = false

function startfishing() 
    local args = {
        {
            kind = "drillRequest",
            clickedX = 1.5
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("TowerService"):WaitForChild("RE"):WaitForChild("remote"):FireServer(unpack(args))
end

function endfishing()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendMouseButtonEvent(200, 300, 0, true, game, 1)
    VirtualInputManager:SendMouseButtonEvent(200, 300, 0, false, game, 1)
end

Tabs.fish:Section({ Title = "AutoFarm", Icon = "database-zap" })

Tabs.fish:Toggle({
    Title = "Fish",
    Desc = "Just Fishing with 1.5x accurate",
    Icon = "fish",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        fishingEnabled = state
        if state then
            task.spawn(function()
                while fishingEnabled do
                    startfishing()
                    task.wait(1)
                    endfishing()
                    task.wait(2.5)
                end
            end)
        end
    end
})


local function safeFire(args)
    local repStorage = game:GetService("ReplicatedStorage")
    local Knit = repStorage:WaitForChild("Packages"):WaitForChild("Knit")
    local AbilityService = Knit.Services:WaitForChild("AbilityService")
    local remote = AbilityService.RE:WaitForChild("remote")
    remote:FireServer(unpack(args))
end

local function twobaits()
    safeFire({[1] = {what="extraBait", kind="abilitySelect"}})
end

local function luck()
    safeFire({[1] = {what="luckBoost", kind="abilitySelect"}})
end

local function weightboost()
    safeFire({[1] = {what="weightX", kind="abilitySelect"}})
end

local function gold()
    safeFire({[1] = {what="fullGold", kind="abilitySelect"}})
end

local selectedUltimate = nil
local autoUltimate = false

Tabs.fish:Section({ Title = "Ultimate", Icon = "smartphone-charging" })

Tabs.fish:Dropdown({
    Title = "Select Ultimate",
    Values = { "2 Extra Baits", "15x Luck Boost", "10x Weight Boost", "100% Gold Fish Chance" },
    Value = nil,
    Callback = function(option)
        selectedUltimate = option
    end
})

Tabs.fish:Toggle({
    Title = "Auto Use Selected Ultimate",
    Desc = "Will automatically use Ultimate after 10 casts",
    Icon = "power",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoUltimate = state

        if autoUltimate then
            task.spawn(function()
                while autoUltimate do
                    task.wait(0.1)

                    if selectedUltimate == "2 Extra Baits" then
                        twobaits()
                    elseif selectedUltimate == "15x Luck Boost" then
                        luck()
                    elseif selectedUltimate == "10x Weight Boost" then
                        weightboost()
                    elseif selectedUltimate == "100% Gold Fish Chance" then
                        gold()
                    end
                end
            end)
        end
    end
})










  
