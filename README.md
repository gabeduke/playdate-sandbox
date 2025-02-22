# Playdate Game Framework

## 🎮 Overview
This project is a **modular Playdate game framework** where:
- **Children’s artwork** can be loaded dynamically to create levels.
- The **game engine** is separate from assets, making it flexible.
- A **mock graphics system** generates placeholder images for development.

## 🏗️ Project Structure
```
📂 game_project/
├── 📂 Source/
│   ├── 📄 main.lua          # Main entry point
│   ├── 📄 engine.lua        # Core game loop and sprite management
│   ├── 📄 sceneLoader.lua   # Loads background & objects
│   ├── 📄 interaction.lua   # Handles player interactions
│   ├── 📄 mockGraphics.lua  # Generates placeholder assets and effects
│   ├── 📂 Images/           # (Optional) Kid's artwork files go here
│   ├── 📂 Data/             # Stores game state if needed
│   └── 📄 README.md         # Project documentation
```

## 🎯 **Design Goals**
1. **Separation of Concerns**  
   - Game logic (movement, collision) is **independent** from artwork.
   - Scenes are **loaded dynamically** from external images or generated mock data.

2. **Mocking for Development**  
   - Procedural backgrounds and sprites are **generated dynamically**.
   - Supports **basic visual effects** (dithering, inversion, blurring).

3. **Modular & Extendable**  
   - New mechanics (like physics, inventory) can be added without modifying core components.
   - Supports **loading custom art assets** when available.

---

## 🏛️ **Class Interactions & Architecture**
Below is the **high-level structure** of our classes/modules and how they interact.

### **1️⃣ `engine.lua` (Game Engine)**
- **Manages game state** (sprites, items, updates).
- Calls `sceneLoader` to load environments.
- Calls `interaction` for event handling.

```lua
engine = {}

function engine:init()
    self.sprites = {}
    self.items = {}
end

function engine:addSprite(sprite)
    table.insert(self.sprites, sprite)
    sprite:add()
end

function engine:update()
    gfx.sprite.update()
end
```

---

### **2️⃣ `sceneLoader.lua` (Scene Loader)**
- Loads artwork from `Images/` or **generates procedural backgrounds** using `mockGraphics`.
- Converts image data into **playable level elements**.

```lua
sceneLoader = {}

function sceneLoader:loadBackground()
    local backgroundImage = mockGraphics:generateMockBackground(400, 240)
    gfx.sprite.setBackgroundDrawingCallback(function() backgroundImage:draw(0, 0) end)
end
```

---

### **3️⃣ `mockGraphics.lua` (Mock Graphics)**
- **Generates procedural assets** instead of requiring real artwork.
- Supports **visual effects** (dithering, inversion, blur).

```lua
mockGraphics = {}

function mockGraphics:generateMockSprite(width, height)
    local img = gfx.image.new(width, height)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, width, height)
    gfx.fillRect(5, 5, width - 10, height - 10)
    gfx.popContext()
    return img
end
```

---

### **4️⃣ `interaction.lua` (Interaction Manager)**
- Handles **collisions**, **object pickups**, and **player interactions**.

```lua
interaction = {}

function interaction:checkCollision(player, objects)
    for _, obj in ipairs(objects) do
        if player:overlappingSprites(obj) then
            print("Item collected!")
        end
    end
end
```

---

### **5️⃣ `main.lua` (Main Game Loop)**
- Initializes the engine, loads scenes, and handles **player movement**.

```lua
function playdate.update()
    updatePlayerMovement()
    engine:update()
end
```

---

## 🚀 **Next Steps**
1. **Improve Movement & Physics**
   - Add **collision detection** with scene objects.
   - Implement **boundary constraints**.

2. **Expand Visual Effects**
   - Support **animated transformations** (wave, shake, etc.).
   - Allow **real-time effect toggling**.

3. **Integrate Real Artwork**
   - Load user-drawn images and **detect scene boundaries**.

---

### 📝 **How to Run the Game**
1. **Open Playdate Simulator**.
2. Load the `main.lua` file inside `Source/`.
3. Use the **D-pad** to move the player.

---

## 📜 **Contributing**
- Contributions are welcome! Feel free to submit **ideas, bug fixes, or enhancements**.

---

### **📌 Notes**
- **Playdate uses `import` instead of `require`** for Lua modules.
- **Only `.pdi` files can be loaded as images** (use `pdc` to convert PNGs).


📂 game_project/
├── 📂 Source/
│   ├── 📂 engine/        
│   │   ├── 📄 engine.lua
│   │   ├── 📄 sceneLoader.lua
│   │   ├── 📄 interaction.lua
│   │   ├── 📄 map.lua
│   │   ├── 📄 player.lua
│   ├── 📂 levels/        
│   │   ├── 📄 level.lua
│   │   ├── 📄 mockLevel.lua
│   │   ├── 📄 level1.lua
│   │   ├── 📄 level2.lua
│   ├── 📂 assets/        # Placeholder for actual images/sprites
│   ├── 📂 graphics/      # Place mockGraphics.lua here
│   │   ├── 📄 mockGraphics.lua
│   ├── 📂 scene/         # Place scene.lua here
│   │   ├── 📄 scene.lua
│   ├── 📄 main.lua       
│   ├── 📄 levelSelector.lua
│   ├── 📄 README.md
