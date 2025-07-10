return function(targetModel, color)
    local function attachHighlight(model, color)
        if model:FindFirstChild("ESP_Highlight") then
            model.ESP_Highlight:Destroy()
        end

        local h = Instance.new("Highlight")
        h.Name = "ESP_Highlight"
        h.FillColor = color or Color3.fromRGB(255, 0, 0)
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.Adornee = model
        h.Parent = model
    end

    task.spawn(function()
        while task.wait(1) do
            if targetModel and targetModel:FindFirstChild("HumanoidRootPart") then
                attachHighlight(targetModel, color)
            end
        end
    end)
end
