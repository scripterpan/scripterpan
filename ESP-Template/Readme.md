## Welcome to Pann's Roblox ESP Template!

Check out [Example](https://github.com/scripterpan/scripterpan/blob/main/ESP-Template/Example.lua) for the esp example!

### Copy this script to use it! (if you're lazy to go to example lol) 
### Also check out the tutorial below! 
### P.S doesn't work for player



```lua
local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

local target = workspace:WaitForChild("Beta")  -- Change to the model you want to highlight
local color = Color3.fromRGB(255, 0, 0)        -- Change to your preferred color

espLib(target, color)  -- Activates ESP on the target
```


# TEST

# 🔦 Roblox ESP Highlight Script

A simple, flexible ESP (Extra Sensory Perception) library for Roblox that adds glow effects to any object using Roblox's built-in `Highlight`.

---

## 📌 What This Is

This script highlights monsters, NPCs, items, or any other object in the game with a glowing effect.  
Perfect for horror games, PvE farming, or item locating.  
It auto-updates every second, so if something respawns, the ESP is reapplied.

---

## 💾 How to Use

### 1. Load the ESP Library

Paste this in your executor or script:

```lua
local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()
```

---

### 2. Use the ESP Function

```lua
espLib(workspace.Beta, Color3.fromRGB(255, 0, 0)) -- Red highlight for "Beta" monster
espLib(workspace.Midnight, Color3.fromRGB(255, 0, 0)) -- Another red ESP
espLib(workspace.Item, Color3.fromRGB(0, 255, 255)) -- Cyan highlight for an item
```

---

## 🎨 ESP Colors

Use `Color3.fromRGB(R, G, B)` to customize glow color:

| Color     | RGB Example                  |
|-----------|------------------------------|
| 🔴 Red    | `Color3.fromRGB(255, 0, 0)`  |
| 🟢 Green  | `Color3.fromRGB(0, 255, 0)`  |
| 🔵 Blue   | `Color3.fromRGB(0, 0, 255)`  |
| 🟡 Yellow | `Color3.fromRGB(255, 255, 0)`|
| 🟣 Purple | `Color3.fromRGB(150, 0, 255)`|

---

## 🧠 How It Works

This ESP library uses Roblox’s native `Highlight` object.  
You can apply it to:

- Models
- Parts
- Folders
- Tools
- Anything inside `workspace`

As long as it exists, the glow will work — no `HumanoidRootPart` or `Humanoid` required.

---

## 🔁 Auto Refresh

ESP is reapplied every second in a loop.  
If the object respawns or is removed/re-added, it will glow again automatically.

---

## 💡 How to Find the Right Path

Use tools like:

- 🧩 **DEX Explorer** – to browse all objects in `workspace`
- 🧪 **SimpleSpy** – to catch monster/item creation
- 🔍 **Executor Object Viewers** – like Synapse Explorer, etc.

Example paths:
```lua
workspace.Beta
workspace.Monsters["Night Hunter"]
workspace.Map.BossRoom.Boss
workspace.Items.SpecialOrb
```

If you're unsure:
```lua
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") or v:IsA("BasePart") then
        print(v:GetFullName())
    end
end
```

---

## ✅ Example Full Script

```lua
local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

espLib(workspace:WaitForChild("Beta"), Color3.fromRGB(255, 0, 0))
espLib(workspace:WaitForChild("Midnight"), Color3.fromRGB(255, 0, 0))
espLib(workspace.Item, Color3.fromRGB(0, 255, 255))
```

---

## ⚙️ Requirements

- Executor with support for:
  - `loadstring`
  - `game:HttpGet`
- No special parts needed (no Humanoid, no RootPart)

---

## 🤝 License

This script is free and open-source.  
Use it, modify it, improve it — just don’t resell it.

---

## 🌐 Credits / Contact

Made with ❤️ by Pann
Check out my full hub or GUI projects:  
👉 [My Profile](https://github.com/scripterpan)
