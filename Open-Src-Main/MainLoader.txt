local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local CheckButton = Instance.new("TextButton")
local OutputLabel = Instance.new("TextLabel")
local GameThumbnail = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local ButtonUICorner = Instance.new("UICorner")
local ButtonUICorner2 = Instance.new("UICorner")
local LoadingBar = Instance.new("Frame")
local LoadingBarFill = Instance.new("Frame")
local ResizeHandle = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")  -- Close button
local Resizing = false
local StartPos
local TimerLabel = Instance.new("TextLabel")  -- Timer label for countdown

-- Set up the ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "Welcome to Pann Hub!"  -- Changed the name to "Welcome to Pann Hub!"

-- Set up the Frame
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 300)  -- Slightly longer UI to fit the supported games list
Frame.Position = UDim2.new(0.5, -150, 0.5, -150)  -- Centered
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BackgroundTransparency = 0.3  -- Make the frame slightly transparent

-- Add UICorner to create squircle effect for the frame
UICorner.CornerRadius = UDim.new(0, 20)  -- Squircle effect
UICorner.Parent = Frame

-- Set up the Output Label
OutputLabel.Parent = Frame
OutputLabel.Size = UDim2.new(0, 250, 0, 40)  -- Larger label size to accommodate checking message
OutputLabel.Position = UDim2.new(0.5, -125, 0.1, 0)  -- Moved to the top of the UI
OutputLabel.Text = "Welcome to Pann Hub!"
OutputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OutputLabel.BackgroundTransparency = 1  -- Make label background fully transparent

-- Set up the Game Thumbnail Image
GameThumbnail.Parent = Frame
GameThumbnail.Size = UDim2.new(0, 80, 0, 80)  -- Changed thumbnail size to 80x80
GameThumbnail.Position = UDim2.new(0.5, -40, 0.4, -40)  -- Moved down slightly
GameThumbnail.BackgroundTransparency = 1  -- Make the background transparent
GameThumbnail.Image = ""  -- Default image, will be updated later

-- Add UICorner to create squircle effect for the thumbnail
ButtonUICorner2.CornerRadius = UDim.new(0, 15)
ButtonUICorner2.Parent = GameThumbnail

-- Set up the Loading Bar
LoadingBar.Parent = Frame
LoadingBar.Size = UDim2.new(0, 250, 0, 12)  -- Slightly bigger bar size
LoadingBar.Position = UDim2.new(0.5, -125, 0.55, 0)  -- Moved higher to fit better
LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingBar.BackgroundTransparency = 0.5  -- Make the loading bar slightly transparent

-- Set up the fill part of the Loading Bar
LoadingBarFill.Parent = LoadingBar
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Add UICorner to create squircle effect for the loading bar
local LoadingBarUICorner = Instance.new("UICorner")
LoadingBarUICorner.CornerRadius = UDim.new(0, 10)
LoadingBarUICorner.Parent = LoadingBar

-- Set up the Check Button (made bigger)
CheckButton.Parent = Frame
CheckButton.Size = UDim2.new(0, 200, 0, 40)  -- Increased the button size
CheckButton.Position = UDim2.new(0.5, -100, 0.7, 0)  -- Moved closer below the loading bar
CheckButton.Text = "Check Place Id and Load the Script"
CheckButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.BackgroundTransparency = 0.3  -- Make the button slightly transparent

-- Add UICorner to create squircle effect for the button
ButtonUICorner.CornerRadius = UDim.new(0, 15)
ButtonUICorner.Parent = CheckButton

-- Set up the Close Button
CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0, 30, 0, 30)  -- Close button size
CloseButton.Position = UDim2.new(1, -40, 0, -10)  -- Positioned at the top right
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundTransparency = 0.5  -- Make the close button slightly transparent

-- Close the UI when the close button is clicked
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Set up the Timer Label (moved to the top of the UI)
TimerLabel.Parent = Frame
TimerLabel.Size = UDim2.new(0, 250, 0, 40)  -- Timer label moved to the top of the UI
TimerLabel.Position = UDim2.new(0.5, -125, 0.05, 0)  -- Moved near the top of the UI
TimerLabel.Text = "Closing in: 0s"
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.BackgroundTransparency = 1  -- Make label background fully transparent

-- Place ID to Game Name mapping
local supportedGames = {
    [6243699076] = "The Mimic",
    [15532962292] = "Sol's RNG",
    [9772878203] = "Raise A Floppa 2",
    [9921522947] = "RAF2 (Multiplayer)",
    [121308443347459] = "7DTL",
    [132991738534170] = "SURVIVE THE JOB APPLICATION"
}

-- Check the current place ID and execute the script
CheckButton.MouseButton1Click:Connect(function()
    -- Destroy the CheckButton once clicked
    CheckButton:Destroy()

    -- Show the loading bar and set the initial text
    OutputLabel.Text = "Checking Place ID..."
    LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)

    -- Simulate a faster loading process
    for i = 1, 100 do
        -- Smooth the progress fill
        LoadingBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        task.wait(0.05)  -- Reduced wait time to make it fill faster
    end

    local placeID = game.PlaceId
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(placeID)
    end)

    if success and gameInfo then
        OutputLabel.Text = "You are playing: " .. gameInfo.Name

        -- Set the game's thumbnail image
        GameThumbnail.Image = "rbxassetid://" .. gameInfo.IconImageAssetId

        -- Check if the game is supported
        if supportedGames[placeID] then  -- Check if the place ID is in the supported games list
            OutputLabel.Text = supportedGames[placeID] .. " is supported \nLoading script..."
            task.wait(1)

            -- Load the script for the game based on PlaceId
            if placeID == 6243699076 then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/TheMimic"))()
            elseif placeID == 15532962292 then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/SolsRNG"))()
            elseif placeID == 9772878203 then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/RaiseAFloppa2"))()
            elseif placeID == 9921522947 then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/RaiseAFloppa2"))()
            elseif placeID == 132991738534170 then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/JobApplication"))()
            elseif placeID == 121308443347459 then
                -- 7DTL
            end

            OutputLabel.Text = supportedGames[placeID] .. " script is loaded, enjoy!"
            print(supportedGames[placeID] .. " script is running!")
        else
            OutputLabel.Text = gameInfo.Name .. " is an unsupported game \nloading universal script!"
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/Universal"))()
            for i = 5, 0, -1 do
                TimerLabel.Text = "Closing in: " .. i .. "s"
                task.wait(1)
            end
            ScreenGui:Destroy()  -- Close the UI if the game is unsupported
        end
    else
        OutputLabel.Text = "Unable to retrieve game information"
    end

    -- Start countdown timer for supported games before destroying the UI (10 seconds)
    if success and gameInfo and supportedGames[placeID] then
        for i = 5, 0, -1 do
            TimerLabel.Text = "Closing in: " .. i .. "s"
            task.wait(1)
        end
        ScreenGui:Destroy()  -- Close the UI after the script is loaded
    end
end)
