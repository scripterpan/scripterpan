local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Raise A Floppa 2",
    Icon = "cat",
    Author = "Pann Hub",
    Folder = "PannHub-WindUi-RAF2",
    Size = UDim2.fromOffset(500, 360),
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
    Title = "Pann Hub (Raise A Floppa 2)",
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

    
    Tabs.main1 = Tabs.main:Tab({ Title = "Main", Icon = "album" })
    Tabs.cook = Tabs.main:Tab({ Title = "Cook", Icon = "cooking-pot" })
    Tabs.auto = Tabs.main:Tab({ Title = "Automatic", Icon = "code" })
    Tabs.Tp = Tabs.main:Tab({ Title = "Teleport", Icon = "arrow-down-to-dot" })
    Tabs.gemisc = Tabs.misc:Tab({ Title = "General Misc", Icon = "tv-minimal"})
    Tabs.plmisc = Tabs.misc:Tab({ Title = "Player Misc", Icon = "person-standing"})
    Tabs.mul = Tabs.Other:Tab({ Title = "Multiplayer", Icon = "users-round" })
    Tabs.src = Tabs.Other:Tab({ Title = "Universal Script & Tools", Icon = "scroll-text" })
    Tabs.exec = Tabs.Other:Tab({ Title = "Built-in Executor (Ok wth)", Icon = "toggle-left" })

end


-- setupain function for teleport 
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


-- setup tp back
local originalCFrame = humanoidRootPart.CFrame

        local function teleportBack()
            humanoidRootPart.CFrame = originalCFrame
        end


-- Setup Tp tp Floppa

        local function teleportToFloppa()
            local floppa = workspace:FindFirstChild("Floppa")

            if floppa then
                humanoidRootPart.CFrame = floppa.HumanoidRootPart.CFrame
            end
        end





-- setup interact 

function interact()
    local function getVisiblePrompt()
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") and v.Enabled and v.Parent:IsA("BasePart") then
                local dist = (hrp.Position - v.Parent.Position).Magnitude
                if dist <= v.MaxActivationDistance then
                    return v
                end
            end
        end
    end

    local prompt = getVisiblePrompt()
    if prompt then
        fireproximityprompt(prompt)
    end
end













Tabs.main1:Button({
    Title = "Floppa's Moodlets",
    Desc = "Feed Floppa Hot Chocolate, Lemonade When Floppa Is Cold, Hot",
    Callback = function() 
        humanoidRootPart.CFrame = CFrame.new(-5.52987146, 69.0936737, -108.875877, 0.307733119, 1.24310662e-09, 0.9514727, -2.64562194e-09, 1, -4.50839088e-10, -0.9514727, -2.37849895e-09, 0.307733119)

        task.wait(0.4)

        interact()

        task.wait(0.3)

        teleportToFloppa()

        task.wait(0.4)

        interact()

        task.wait(0.45)

        teleportBack()
end
})


Tabs.main1:Button({
    Title = "Activate Meteorite Magnet",
    Desc = "Activate Meteorite Magnet if purchase",
    Callback = function() 
          local function hasMeteoriteMagnet()
            local meteoriteMagnet = workspace.Unlocks:FindFirstChild("Meteor Magnet")  -- Check if Meteor Magnet is in the Unlocks folder
            return meteoriteMagnet ~= nil
        end

        if hasMeteoriteMagnet() then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-46.8612709, 153.73613, -41.5506172)
            task.wait(0.45)
            interact () 
            task.wait(0.5)
            teleportBack()
end
end
})
