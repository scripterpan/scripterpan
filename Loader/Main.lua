local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()


local creator = game.CreatorId

local games = {
    [14179659] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/RaiseAFloppa2.lua', -- Raise A Floppa 2
    [8509669] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/SolsRNG.lua', -- Sols RNG
    [9482918] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/TheMimic.lua', -- The Mimic
    [8401765] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/JobApplication.lua', -- Survive The Job Application
    [32900163] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/PETAPETA.lua', -- PETAPETA (Original and School)
    [33541525] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/7DTL.lua', -- 7 Days To Live
    [7314991] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/Nightlight.lua', -- Nightlight (Horror)
}

WindUI:Popup({
    Title = "Welcome To Pann Hub",
    Icon = "info",
    Content = "Do you want to use/load our script?",
    Buttons = {
        {
            Title = "Cancel",
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = "Continue",
            Icon = "arrow-right",
            Callback = function()
                repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character
                if not game:IsLoaded() then
                    game.Loaded:Wait()
                end

                WindUI:Notify({
                    Title = "Checking if this game is supported or not",
                    Content = "did you know, idk how to use dex?",
                    Icon = "info",
                    Duration = 5,
                })
                task.wait(2.5)
                if games[creator] then
                    WindUI:Notify({
                        Title = "Supported!",
                        Content = "Loading,  please wait",
                        Icon = "info",
                        Duration = 5,
                    })
                    loadstring(game:HttpGet(games[creator]))()
                else
                    WindUI:Notify({
                        Title = "Unsupported",
                        Content = "We'll be adding the list of supported games soon",
                        Icon = "info",
                        Duration = 5,
                    })
                end
            end,
            Variant = "Primary",
        }
    }
})
