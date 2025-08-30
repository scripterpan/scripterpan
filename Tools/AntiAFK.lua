-- antiafk by luca5432 the goat


local gui = Instance.new("ScreenGui")
local header = Instance.new("TextLabel")
local container = Instance.new("Frame")
local footer = Instance.new("TextLabel")
local status = Instance.new("TextLabel")

gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

header.Parent = gui
header.Active = true
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.Position = UDim2.new(0.7, 0, 0.1, 0)
header.Size = UDim2.new(0, 370, 0, 52)
header.Font = Enum.Font.SourceSansSemibold
header.Text = "Anti AFK"
header.TextColor3 = Color3.fromRGB(0, 255, 255)
header.TextSize = 22
header.Draggable = true

container.Parent = header
container.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
container.Position = UDim2.new(0, 0, 1, 0)
container.Size = UDim2.new(0, 370, 0, 107)

footer.Parent = container
footer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
footer.Position = UDim2.new(0, 0, 0.8, 0)
footer.Size = UDim2.new(0, 370, 0, 21)
footer.Font = Enum.Font.Arial
footer.Text = "Made by luca#5432"
footer.TextColor3 = Color3.fromRGB(0, 255, 255)
footer.TextSize = 20

status.Parent = container
status.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
status.Position = UDim2.new(0, 0, 0.15, 0)
status.Size = UDim2.new(0, 370, 0, 44)
status.Font = Enum.Font.ArialBold
status.Text = "Status: Active"
status.TextColor3 = Color3.fromRGB(0, 255, 255)
status.TextSize = 20

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:CaptureController()
    vu:ClickButton2(Vector2.new())
    status.Text = "Roblox tried kicking you but I stopped it!"
    task.wait(2)
    status.Text = "Status: Active"
end)
