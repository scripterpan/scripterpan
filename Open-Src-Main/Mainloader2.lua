-- Thanks to x2zu for ts bro (i haven't edit all of them)
repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Pann Loader";
    Text = "Supported game!";
    Duration = 5;
})

local creator = game.CreatorId

local games = {
    [14179659] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/RaiseAFloppa2.lua', -- Raise A Floppa 2
    [8509669] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/My%20Fishing%20Pier.lua', -- Sols RNG
    [9482918] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/Dungeon%20Heroes.lua', -- The Mimic
    [8401765] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/Anime%20Shadow2.lua', -- Survive The Job Application
    [32900163] = 'https://raw.githubusercontent.com/x2zu/loader/main/ObfSource/BloxFruits.lua', -- PETAPETA (Original and School)
    [33541525] = 'https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/ObfSource/OneTouch.lua', -- 7 Days To Live
}

if games[creator] then
    StarterGui:SetCore("SendNotification", {
        Title = "Pann Loader";
        Text = "Loading,  Please wait..";
        Duration = 5;
    })

    loadstring(game:HttpGet(games[creator]))()
else
    StarterGui:SetCore("SendNotification", {
        Title = "Pann Loader";
        Text = "Unsupported game.";
        Duration = 5;
    })
end
