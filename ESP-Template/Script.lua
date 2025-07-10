--// ESP Template Script

local function createESP(target, color)
    if not target then return end

    local function addHighlight(obj)
        if not obj:FindFirstChildOfClass("Highlight") then
            local hl = Instance.new("Highlight")
            hl.Name = "ESP_Highlight"
            hl.FillColor = color or Color3.fromRGB(255, 0, 0)
            hl.OutlineTransparency = 1
            hl.FillTransparency = 0.3
            hl.Parent = obj
        end
    end

    addHighlight(target)

    -- Keep refreshing in case the object respawns
    task.spawn(function()
        while task.wait(1) do
            if target and target.Parent then
                addHighlight(target)
            end
        end
    end)
end

return function(target, color)
    createESP(target, color)
end
