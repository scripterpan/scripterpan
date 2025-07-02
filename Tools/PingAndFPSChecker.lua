local Players = game:GetService("Players")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove existing UI if present
if playerGui:FindFirstChild("PingAndFPS") then
    playerGui.PingAndFPS:Destroy()
end

-- Create main UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PingAndFPS"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Ping Label
local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 140, 0, 24)
pingLabel.Position = UDim2.new(1, -10, 0, 10)
pingLabel.AnchorPoint = Vector2.new(1, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.TextStrokeTransparency = 0.5
pingLabel.TextScaled = true
pingLabel.Font = Enum.Font.SourceSansBold
pingLabel.Text = "Ping: ..."
pingLabel.Parent = screenGui

-- FPS Label
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 140, 0, 24)
fpsLabel.Position = UDim2.new(1, -10, 0, 40) -- under ping
fpsLabel.AnchorPoint = Vector2.new(1, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextStrokeTransparency = 0.5
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.Text = "FPS: ..."
fpsLabel.Parent = screenGui

-- FPS measurement
local frames = 0
local lastTime = tick()
local fps = 60

game:GetService("RunService").RenderStepped:Connect(function()
	frames += 1
	local currentTime = tick()
	if currentTime - lastTime >= 1 then
		fps = frames
		frames = 0
		lastTime = currentTime
	end
end)

-- Update both counters
while true do
    -- FPS update
    fpsLabel.Text = "FPS: " .. fps

    -- Ping update
    local ping
    pcall(function()
        local network = Stats:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local dataPing = serverStats and serverStats:FindFirstChild("Data Ping")
        if dataPing then
            ping = dataPing:GetValue()
        end
    end)

    if ping then
        ping = math.floor(ping)
        pingLabel.Text = "Ping: " .. ping .. " ms"

        -- 🟢🟡🔴 Custom color range
        if ping < 150 then
            pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green
        elseif ping <= 250 then
            pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow
        else
            pingLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red
        end
    else
        pingLabel.Text = "Ping: N/A"
        pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    task.wait(1)
end


-- Holy ChatGPT
