-- Just a testing, not an important thing

return function(targetModel, color)
    local function attachHighlightAndName(model, color)
        if model:FindFirstChild("ESP_Highlight") then
            model.ESP_Highlight:Destroy()
        end
        if model:FindFirstChild("ESP_NameGui") then
            model.ESP_NameGui:Destroy()
        end

        -- Highlight
        local h = Instance.new("Highlight")
        h.Name = "ESP_Highlight"
        h.FillColor = color or Color3.fromRGB(255, 0, 0)
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.Adornee = model
        h.Parent = model

        -- Billboard Name Tag (smaller)
        local gui = Instance.new("BillboardGui")
        gui.Name = "ESP_NameGui"
        gui.Adornee = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
        gui.Size = UDim2.new(0, 60, 0, 20) -- Text Size
        gui.StudsOffset = Vector3.new(0, 0, 0)
        gui.AlwaysOnTop = true
        gui.Parent = model

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = model.Name
        label.TextColor3 = color or Color3.fromRGB(255, 0, 0)
        label.TextStrokeTransparency = 0.5
        label.TextScaled = true
        label.Font = Enum.Font.GothamSemibold
        label.Parent = gui
    end

    task.spawn(function()
        while task.wait(1) do
            if targetModel then
                attachHighlightAndName(targetModel, color)
            end
        end
    end)
end
