-- 👤 Player setup
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- 🎯 Fixed return location
local returnCFrame = CFrame.new(
    -2.5736208, 3.99999952, -33.1137161,
    -0.99617213, 2.56622257e-09, 0.0874134079,
    9.0748884e-09, 1, 7.40610417e-08,
    -0.0874134079, 7.45708135e-08, -0.99617213
)

-- 🖼️ GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "PaycheckAutoCollector_" .. tostring(math.random(1000, 9999))

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 150, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -75, 0, 100)
ToggleButton.Text = "Auto Collect: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.BorderSizePixel = 0
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.Active = true
ToggleButton.Draggable = true

-- 🔁 State
local collecting = false
local collectedAtLeastOne = false

-- 🖱️ Toggle
ToggleButton.MouseButton1Click:Connect(function()
    collecting = not collecting
    ToggleButton.Text = collecting and "Auto Collect: ON" or "Auto Collect: OFF"

    if not collecting and collectedAtLeastOne and hrp then
        hrp.CFrame = returnCFrame
    end
end)

-- 🔁 Loop
spawn(function()
    while true do
        if collecting then
            character = player.Character or player.CharacterAdded:Wait()
            hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then task.wait(0.5) continue end

            local drops = workspace:FindFirstChild("PaycheckDrops")
            if not drops then task.wait(0.5) continue end

            local paycheckFound = false

            for _, drop in pairs(drops:GetChildren()) do
                if not collecting then break end
                if drop:IsA("BasePart") then
                    paycheckFound = true
                    hrp.CFrame = drop.CFrame
                    task.wait(0.2)
                end
            end

            if paycheckFound then
                collectedAtLeastOne = true
                task.wait(0.1)
                if collecting then
                    hrp.CFrame = returnCFrame
                end
            end
        end
        task.wait(0.3)
    end
end)
