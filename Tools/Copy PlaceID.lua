local id = tostring(game.PlaceId)
setclipboard(id)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Place ID";
    Text = "Copied to clipboard: " .. id;
    Duration = 5;
})
