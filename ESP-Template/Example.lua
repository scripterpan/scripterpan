--ESP Module for Roblox

This is a simple ESP (highlight) script you can load into Roblox scripts to highlight any model with a glowing outline.

-- How to use


local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

local target = workspace:WaitForChild("Beta")  -- Change to the model you want to highlight
local color = Color3.fromRGB(255, 0, 0)        -- Change to your preferred color

espLib(target, color)  -- Activates ESP on the target
