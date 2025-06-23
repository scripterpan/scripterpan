-- Thanks to x2zu for ts bro (i haven't edit all of them)
repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Loader";
    Text = "Supported game!";
    Duration = 5;
})

local creator = game.CreatorId

local games = {
    [8605341] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/Pixel%20Blade.lua', -- Pixel Blade
    [35980748] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/My%20Fishing%20Pier.lua', -- My Fishing Pier
    [3739465] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/Dungeon%20Heroes.lua', -- Dungeon Heroes
    [35812225] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/Anime%20Shadow2.lua', -- Anime Shadow 2 (Maintance)
    [4372130] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/BloxFruits.lua', -- Blox Fruits
    [35860275] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/OneTouch.lua', -- One Touch
    [34063840] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/AnimeRising.lua', -- Anime Rising (Maintance)
    [5096106] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/AnimeRails.lua', -- Anime Rails
    [35815907] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/StealABrainrot.lua', -- Steal A Brainrot
    [12836673] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/BladeBall.lua', -- Blade Ball
    [6042520] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/99Nights.lua', -- 99 Nights
}

if games[creator] then
    StarterGui:SetCore("SendNotification", {
        Title = "Loader";
        Text = "Loading,  Please wait..";
        Duration = 5;
    })

    loadstring(game:HttpGet(games[creator]))()
else
    StarterGui:SetCore("SendNotification", {
        Title = "Loader";
        Text = "Unsupported game.";
        Duration = 5;
    })
end
