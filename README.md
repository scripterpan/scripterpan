local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Pan Script Hub", "DarkTheme")

-- MAIN
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Main(indev)")


-- GAME
local Game = Window:NewTab("Game")
local GameSection = Game:NewSection("Game")

GameSection:NewButton("Blox fruits (halo hub)", "Halo Hub", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/HALOxHUB/HALOxHUBNOTTHEBESTSCRIPT/main/BLOXFRUIT.lua'))()
end)

GameSection:NewButton("bedwars (vape v4)", "vape v4", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

GameSection:NewButton("Piggy (TP tool)", "Tp tool but piggy", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/mBiYCGUR"))()
end)

GameSection:NewButton("mm2 (eclipse v1) ", "eclipse v1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ethanoj1/EclipseMM2/master/Script", true))()
end)

GameSection:NewButton("Apeirophobia (shadow hub) ", "apiro but shadown hub", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ShadowScripts4Roblox/PROTECTEDLUA/main/Scripts/APEIROPHOBIA/1.0.%3Blua'))()
end)

GameSection:NewButton("The intruder ", "idk what name of this hub", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/FGjjwm6W"))()
end)

GameSection:NewButton("Doors ", "doors but shadow hub", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ShadowScripts4Roblox/PROTECTEDLUA/main/Scripts/DOORS/Loader52.lua'))()
end)


--FE
local FE = Window:NewTab("FE")  
local FESection = FE:NewSection("FE")

FESection:NewButton("FE emote", "Emote (Very nice for me)", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/eCpipCTH"))()
end)

FESection:NewButton("FE Infinite Yield", "FE Admin Commands", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)


--LOCAL PLAYER
local Player = Window:NewTab("local Player")
local PlayerSection = Player:NewSection("local Player")

PlayerSection:NewSlider("Walkspeed", "SPEED!!", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("Jumppower", "JUMP HIGH!!", 350, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("Reset WS/JP", "Resets to all defaults", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

PlayerSection:NewButton("InfJump(click it and press r)", "Love jump? use this", function()
    _G.infinjump = true
 
    local Player = game:GetService("Players").LocalPlayer
    local Mouse = Player:GetMouse()
    Mouse.KeyDown:connect(function(k)
    if _G.infinjump then
    if k:byte() == 32 then
    Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    Humanoid:ChangeState("Jumping")
    wait(0.1)
    Humanoid:ChangeState("Seated")
    end
    end
    end)
     
    local Player = game:GetService("Players").LocalPlayer
    local Mouse = Player:GetMouse()
    Mouse.KeyDown:connect(function(k)
    k = k:lower()
    if k == "r" then
    if _G.infinjump == true then
    _G.infinjump = false
    else
    _G.infinjump = true
    end
    end
    end)
end)


--Other
local Other = Window:NewTab("Other")
local OtherSection = Other:NewSection("Other")
OtherSection:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.Q, function()
	print("You just clicked the bind")
end)
OtherSection:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.Q, function()
	Library:ToggleUI()
end)

--Misc
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc")

MiscSection:NewButton("Fullbright", "AAA my eyes!!!", function()
    pcall(function()
        local lighting = game:GetService("Lighting");
        lighting.Ambient = Color3.fromRGB(255, 255, 255);
        lighting.Brightness = 1;
        lighting.FogEnd = 1e10;
        for i, v in pairs(lighting:GetDescendants()) do
            if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false;
            end;
        end;
        lighting.Changed:Connect(function()
            lighting.Ambient = Color3.fromRGB(255, 255, 255);
            lighting.Brightness = 1;
            lighting.FogEnd = 1e10;
        end);
        spawn(function()
            local character = game:GetService("Players").LocalPlayer.Character;
            while wait() do
                repeat wait() until character ~= nil;
                if not character.HumanoidRootPart:FindFirstChildWhichIsA("PointLight") then
                    local headlight = Instance.new("PointLight", character.HumanoidRootPart);
                    headlight.Brightness = 1;
                    headlight.Range = 60;
                end;
            end;
        end);
    end)
end)

MiscSection:NewButton("Noclip (for Pc Only(read info))", "press x to turn on-off noclip (if it didnt work just reset)", function()
    local Players, RService = game:GetService("Players"), game:GetService("RunService");
    local LocalP, Mouse = Players.LocalPlayer, Players.LocalPlayer:GetMouse();
    local Rm, Index, NIndex, NCall, Caller = getrawmetatable(game), getrawmetatable(game).__index, getrawmetatable(game).__newindex, getrawmetatable(game).__namecall, checkcaller or is_protosmasher_caller
    local NoClip, NoClipKey = false, "x" -- change 'x' to whatever you want
    setreadonly(Rm, false)
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/Universal-Scripts/main/Notification%20Function", true))()
    Notify("zxciaz", "Press F9 for Directions", "", 4);
    warn("NoClip + Bypass made by zxciaz");
    warn("Press "..string.upper(NoClipKey).." to turn off and on NoClip");
    
    Rm.__newindex = newcclosure(function(self, Meme, Value)
        if Caller() then return NIndex(self, Meme, Value) end 
        if tostring(self) == "HumanoidRootPart" or tostring(self) == "Torso" then 
            if Meme == "CFrame" and self:IsDescendantOf(LocalP.Character) then 
                return true -- Credits to ze_lI for this
            end
        end
        return NIndex(self, Meme, Value)
    end)
    setreadonly(Rm, true)
    
    RService.Stepped:Connect(function()
        if NoClip == true and LocalP and LocalP.Character and LocalP.Character:FindFirstChild("Humanoid") then 
            pcall(function() -- fuck errors
                LocalP.Character.Head.CanCollide = false 
                LocalP.Character.Torso.CanCollide = false
            end)
        end
    end)
    
    Mouse.KeyDown:Connect(function(Key)
        if Key == NoClipKey then 
            NoClip = not NoClip
            Notify("zxciaz", "NoClip: "..tostring(NoClip), "", 3)
        end
    end)
end)

MiscSection:NewButton("Fps checker", "Fps For who want to know", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/littlegui/main/FPS-Counter'))()
end)

MiscSection:NewButton("Fly gui(For Mobile Only)", "Gui", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/YvKv4AuY'),true))();
end)

MiscSection:NewButton("Esp", "Esp player", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/gwN6fn2v"))()
end)

MiscSection:NewButton("Zoom (Read info)", "zoom (like make you see something near)", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GA0KFgYb"))()
end)

