# 🔦 Roblox ESP Highlight Script By Pann

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
#### There's like a multiple target version and single target version for this

## ❗IMPORTANT❗ 
Put this below the loadstring first

```lua
local target = workspace:WaitForChild("Example")  -- Change to the model you want to highlight
local color = Color3.fromRGB(255, 0, 0) -- Your highlights color
```

#### Activate The ESP (Single Target)

```lua
espLib(target, color)
```


#### Activate The ESP (Multiple Target)


```lua
espLib(workspace.Beta, Color3.fromRGB(255, 0, 0)) -- Red highlight for monster/ghost
espLib(workspace.Midnight, Color3.fromRGB(255, 0, 0)) -- Another red ESP
espLib(workspace.Item, Color3.fromRGB(0, 255, 255)) -- Cyan highlight for an item
```



#### Full Script Example Of Both Single And Multiple At The End
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

## 🔢 ESP Using Indexes from `GetChildren()`

If you know the exact position of the model or part in `workspace`,  
you can grab it directly using:

```lua
local target = workspace:GetChildren()[54]
espLib(target, Color3.fromRGB(255, 0, 0))
```

This is helpful when:

- The object has no name
- The name is shared with other items
- You’re just testing or exploring with DEX or print logs

> 🔁 You can also ESP a range of them like this:

```lua
for i = 50, 60 do
    local obj = workspace:GetChildren()[i]
    if obj then
        espLib(obj, Color3.fromRGB(255, 0, 0))
    end
end
```

---

> ⚠️ **Note:** Be careful with this method — object positions in `:GetChildren()` can change between server loads or updates.  
If possible, prefer using names or folders instead:

```lua
for _, monster in pairs(workspace.Monsters:GetChildren()) do
    espLib(monster, Color3.fromRGB(255, 0, 0))
end
```

---

## 🔍 How to Find the Index?

Use a script like this to print all children with their indexes:

```lua
for i, v in pairs(workspace:GetChildren()) do
    print(i, v.Name)
end
```

Then grab the index number from the output and apply ESP to it.

---

---

# 📚 Understanding GetChildren() and FindFirstChild() in Roblox Lua

## GetChildren()

What it does:
Returns an array (table) of all immediate child instances of a Roblox Instance (like a Folder, Model, or Workspace).

## Example:

```lua
local children = workspace.SomeFolder:GetChildren()
for i, child in ipairs(children) do
    print(child.Name)
end
```

This prints the names of all direct children inside SomeFolder.

## Important:
GetChildren() only returns children that are one level down — it does not return grandchildren or deeper descendants.



---

## FindFirstChild(name)

## What it does:
Looks for the first child of the instance with the specified name.
If found, it returns the child instance; otherwise, it returns nil.

## Example:

```lua
local part = workspace.SomeModel:FindFirstChild("HumanoidRootPart")
if part then
    print("Found HumanoidRootPart!")
else
    print("HumanoidRootPart not found.")
end
```


## Why use it:
It’s a safe way to check if a child exists before trying to use it. This prevents errors when accessing properties or methods on nil.



---

## When to Use Which?

## Use GetChildren() when you want to loop through all immediate children and do something with each.

## Use FindFirstChild(name) when you want to access a specific child by name but aren’t sure if it exists.



---

## Example in ESP Context

Suppose you want to highlight all parts inside a folder named "Coins":


```lua
local coinsFolder = workspace:FindFirstChild("Coins")
if coinsFolder then
    for _, coin in pairs(coinsFolder:GetChildren()) do
        espLib(coin, Color3.fromRGB(255, 255, 0)) -- highlight coin with yellow
    end
end
```


## Here:

FindFirstChild("Coins") safely checks if "Coins" folder exists.

GetChildren() gets all coin parts inside that folder to highlight each.






---

## ✅ Example Full Script (Multiple Target)

```lua
local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

espLib(workspace:WaitForChild("Beta"), Color3.fromRGB(255, 0, 0))
espLib(workspace:WaitForChild("Midnight"), Color3.fromRGB(255, 0, 0))
espLib(workspace.Item, Color3.fromRGB(0, 255, 255))
```

## ✅ Example Full Script (Single Target)

```lua
local espLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/scripterpan/scripterpan/refs/heads/main/ESP-Template/Script.lua"))()

local target = workspace:WaitForChild("Example")  -- Change to the model you want to highlight
local color = Color3.fromRGB(255, 0, 0)

espLib(target, color)
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
👉 Discord : floppapan9287
