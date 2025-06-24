if game.CreatorType == Enum.CreatorType.Group then
    local id = tostring(game.CreatorId)
    setclipboard(id)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Group ID";
        Text = "Copied to clipboard: " .. id;
        Duration = 5;
    })
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Group ID";
        Text = "Not a group-owned game.";
        Duration = 5;
    })
end
