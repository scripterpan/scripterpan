-- Example
-- This one is the old example it might work or not 
-- You can look for the new example in readme.md


local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

local target = workspace:WaitForChild("Example")  -- Change to the model you want to highlight
local color = Color3.fromRGB(255, 0, 0)        -- Change to your preferred color

espLib(target, color)  -- Activates ESP on the target
