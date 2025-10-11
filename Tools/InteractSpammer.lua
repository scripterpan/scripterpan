local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


if playerGui:FindFirstChild("PromptTester") then
	playerGui.PromptTester:Destroy()
end

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PromptTester"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 170)
frame.Position = UDim2.new(0, -300, 0, 20) -- starts hidden (slide-in)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌀 Proximity Prompt Tool"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "✖"
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(40,40,80)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25,25,25))
}
gradient.Rotation = 90
gradient.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.Text = "Auto Prompt: OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 16
toggleBtn.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleBtn

local modeBtn = Instance.new("TextButton")
modeBtn.Size = UDim2.new(1, -20, 0, 30)
modeBtn.Position = UDim2.new(0, 10, 0, 90)
modeBtn.Text = "Mode: Universal Spam"
modeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 170)
modeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
modeBtn.Font = Enum.Font.Gotham
modeBtn.TextSize = 14
modeBtn.Parent = frame

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 8)
modeCorner.Parent = modeBtn

local delayBox = Instance.new("TextBox")
delayBox.Size = UDim2.new(1, -20, 0, 30)
delayBox.Position = UDim2.new(0, 10, 0, 130)
delayBox.Text = "0.05"
delayBox.ClearTextOnFocus = false
delayBox.PlaceholderText = "Spam Delay (seconds)"
delayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
delayBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 14
delayBox.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = delayBox

-- Variables
local running = false
local isKeyInteractMode = false
local allPrompts = {}
local spamTask = nil
local guiVisible = true


local function tweenColor(obj, color)
	TweenService:Create(obj, TweenInfo.new(0.25), {BackgroundColor3 = color}):Play()
end

local function tweenPosition(obj, goal)
	TweenService:Create(obj, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = goal}):Play()
end

local function safeTonumber(s, default)
	local n = tonumber(s)
	if not n or n <= 0 then return default end
	return n
end

local function firePrompt(prompt)
	if prompt and prompt.Parent then
		pcall(function()
			if fireproximityprompt then
				fireproximityprompt(prompt, 1)
			else
				ProximityPromptService:InputHoldBegin(prompt)
				if prompt.HoldDuration > 0 then
					task.wait(prompt.HoldDuration + 0.05)
				end
				ProximityPromptService:InputHoldEnd(prompt)
			end
		end)
	end
end

local function setupPrompts()
	allPrompts = {}
	for _, instance in ipairs(Workspace:GetDescendants()) do
		if instance:IsA("ProximityPrompt") then
			table.insert(allPrompts, instance)
		end
	end
end

ProximityPromptService.PromptShown:Connect(function(prompt)
	if not table.find(allPrompts, prompt) then
		table.insert(allPrompts, prompt)
	end
end)

local function setMode(enable)
	if spamTask then 
		task.cancel(spamTask)
		spamTask = nil
	end

	running = enable

	if enable then
		setupPrompts()
		tweenColor(toggleBtn, Color3.fromRGB(0, 170, 80))
		toggleBtn.Text = isKeyInteractMode and "Key Interact: ON" or "Universal Spam: ON"

		for _, prompt in ipairs(allPrompts) do
			prompt.MaxActivationDistance = math.huge
			prompt.Enabled = true
		end

		local spamDelay = safeTonumber(delayBox.Text, 0.05)

		if isKeyInteractMode then
			spamTask = task.spawn(function()
				while running do
					if UserInputService:IsKeyDown(Enum.KeyCode.E) then
						for _, prompt in ipairs(allPrompts) do
							firePrompt(prompt)
						end
						task.wait(spamDelay)
					else
						task.wait(0.1)
					end
				end
			end)
		else
			spamTask = task.spawn(function()
				while running do
					for _, prompt in ipairs(allPrompts) do
						firePrompt(prompt)
					end
					task.wait(spamDelay)
				end
			end)
		end
	else
		toggleBtn.Text = "Auto Prompt: OFF"
		tweenColor(toggleBtn, Color3.fromRGB(100, 100, 100))
	end
end


tweenPosition(frame, UDim2.new(0, 20, 0, 20))


toggleBtn.MouseButton1Click:Connect(function()
	setMode(not running)
end)

modeBtn.MouseButton1Click:Connect(function()
	isKeyInteractMode = not isKeyInteractMode
	if isKeyInteractMode then
		modeBtn.Text = "Mode: Interact with Key 'E'"
	else
		modeBtn.Text = "Mode: Universal Spam"
	end
	if running then
		setMode(true)
	end
end)

-- Close button logic
closeBtn.MouseButton1Click:Connect(function()
	if guiVisible then
		tweenPosition(frame, UDim2.new(0, -300, 0, 20))
	else
		tweenPosition(frame, UDim2.new(0, 20, 0, 20))
	end
	guiVisible = not guiVisible
end)
