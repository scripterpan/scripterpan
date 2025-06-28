repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Pann Loader";
    Text = "Checking if this game support or not!";
    Duration = 5;
})

local creator = game.CreatorId

local games = {
    [14179659] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/RaiseAFloppa2.lua', -- Raise A Floppa 2
    [8509669] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/SolsRNG.lua', -- Sols RNG
    [9482918] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/TheMimic.lua', -- The Mimic
    [8401765] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/JobApplication.lua', -- Survive The Job Application
    [32900163] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/PETAPETA.lua', -- PETAPETA (Original and School)
    [33541525] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/7DTL.lua', -- 7 Days To Live
}


task.wait(1.5)


if games[creator] then
    StarterGui:SetCore("SendNotification", {
        Title = "Pann Loader";
        Text = "Supported, Loading, Please wait..";
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
