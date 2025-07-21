-- Super Max Anti-Lag Script (with Player Character Protection)

-- Services
local debris = game:GetService("Debris")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local runService = game:GetService("RunService")

-- Settings
local maxDebrisTime = 5 -- Max time before debris is removed
local partLimitPerPlayer = 500 -- Max parts per player
local maxParts = 5000 -- Max total parts allowed in workspace
local physicsThrottle = Enum.PhysicsSimulationRate.Fixed240Hz -- Reduce physics complexity

-- Function to check if a part is part of a player's character
local function isPartOfPlayerCharacter(part)
    if part:IsDescendantOf(players) then
        return true
    end
    for _, player in pairs(players:GetPlayers()) do
        if player.Character and part:IsDescendantOf(player.Character) then
            return true
        end
    end
    return false
end

-- Function to clean unanchored parts (but ignore player parts)
local function cleanUpUnanchoredParts()
    while true do
        wait(2)
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored and not isPartOfPlayerCharacter(part) then
                debris:AddItem(part, maxDebrisTime)
            end
        end
    end
end

-- Function to reduce part count per player (without removing character parts)
local function limitPartCountForPlayers()
    while true do
        wait(5)
        for _, player in pairs(players:GetPlayers()) do
            local totalParts = 0
            if player.Character and player.Character.Parent then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        totalParts = totalParts + 1
                    end
                end
            end
            if totalParts > partLimitPerPlayer then
                -- Do not remove parts of the player's character
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and not isPartOfPlayerCharacter(part) then
                        debris:AddItem(part, maxDebrisTime)
                    end
                end
            end
        end
    end
end

-- Function to globally reduce part count in the workspace (excluding player parts)
local function limitGlobalPartCount()
    while true do
        wait(10)
        local totalParts = 0
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not isPartOfPlayerCharacter(part) then
                totalParts = totalParts + 1
            end
        end

        if totalParts > maxParts then
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part.Anchored and not isPartOfPlayerCharacter(part) then
                    debris:AddItem(part, maxDebrisTime)
                end
            end
        end
    end
end

-- Optimize Lighting (removes shadows, sets clock to static time to reduce resource usage)
local function optimizeLighting()
    lighting.GlobalShadows = false
    lighting.ClockTime = 12 -- Set to a fixed time (no dynamic lighting)
end

-- Physics Optimization
local function optimizePhysics()
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default
    settings().Physics.AllowSleep = true -- Allow parts to 'sleep' when stationary
    runService.Stepped:Connect(function()
        settings().Physics.PhysicsSimulationRate = physicsThrottle
    end)
end

-- Optimize memory usage by cleaning up unused instances
local function optimizeMemory()
    game:GetService("GarbageCollectorService"):RequestGarbageCollection() -- Force garbage collection
end

-- Main optimization script
local function startOptimization()
    spawn(cleanUpUnanchoredParts)       -- Regularly clean unanchored parts (excluding player parts)
    spawn(limitPartCountForPlayers)     -- Limit part count for each player (without resetting characters)
    spawn(limitGlobalPartCount)         -- Limit the total part count in the workspace (excluding players)
    optimizeLighting()                  -- Optimize lighting settings
    optimizePhysics()                   -- Optimize physics performance
    optimizeMemory()                    -- Optimize memory usage
end

-- Run the optimization
startOptimization()
