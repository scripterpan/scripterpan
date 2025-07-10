# Welcome to Pann's Roblox ESP Template!

Check out [Example](https://github.com/scripterpan/scripterpan/blob/main/ESP-Template/Example.lua) for the esp example!

### Copy this script to use it! (if you're lazy to go to example lol) 
### Also check out the tutorial below! 
### P.S doesn't work for player



```lua
local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

local target = workspace:WaitForChild("Beta")  -- Change to the model you want to highlight
local color = Color3.fromRGB(255, 0, 0)        -- Change to your preferred color

espLib(target, color)  -- Activates ESP on the target
