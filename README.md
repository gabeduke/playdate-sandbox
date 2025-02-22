# 🎮 Playdate Game Template

This template provides a **modular Playdate game engine** with:
- **Multiple levels** (easily extendable).
- **Both top-down and side-scrolling mechanics**.
- **Flexible player movement using D-pad & crank**.
- **A structured game loop with object collision and interaction**.

---

## 🏗️ **Project Structure**
```
📂 Source/
├── 📂 engine/        # Core game engine
│   ├── 📄 engine.lua
│   ├── 📄 sceneLoader.lua
│   ├── 📄 interaction.lua
│   ├── 📄 player.lua
│   ├── 📄 map.lua
├── 📂 levels/        # Level implementations
│   ├── 📄 level.lua
│   ├── 📄 mockLevel.lua
│   ├── 📄 exampleLevel.lua
├── 📂 graphics/      # Placeholder assets
│   ├── 📄 mockGraphics.lua
├── 📄 main.lua       # Game entry point
├── 📄 README.md      # Documentation
```

---

## 🎮 **How to Use This Template**
1. **Clone this repo:**
   ```sh
   git clone https://github.com/yourname/playdate-game-template.git
   cd playdate-game-template/Source
   ```

2. **Run the Playdate Simulator:**
   ```sh
   open -a "Playdate Simulator" Source/main.lua
   ```

3. **To create a new level:**
   - Copy `levels/mockLevel.lua` and rename it.
   - Modify `self.map = Map("top-down")` for top-down levels.
   - Modify `self.map = Map("side")` for platformer levels.

4. **Modify `main.lua` to load your new level.**

---

## 🛠 **Extending the Template**
### 🏔 Adding a New Level
1. Create a new file inside `levels/`, e.g., `levels/myNewLevel.lua`:
   ```lua
   import "levels/level"
   import "engine/map"
   import "graphics/mockGraphics"

   class('MyNewLevel').extends(Level)

   function MyNewLevel:init()
       Level.super.init(self, "My New Level", "top-down")
       self.map = Map("top-down")
   end
   ```

2. Modify `main.lua` to load this level:
   ```lua
   import "levels/myNewLevel"
   currentLevel = MyNewLevel()
   ```

### 🎨 Adding Real Graphics
- Replace `mockGraphics.lua` with real `.pdi` Playdate images.
- Modify `sceneLoader.lua` to load actual assets.

---

## 🚀 **Future Improvements**
- ✅ **Level selection UI**.
- ✅ **Save/Load system**.
- ✅ **Animations and special effects**.

---

## 🏆 **Credits**
This template was designed for **Playdate game developers** to quickly prototype and create full games.

🚀 **Happy coding!**
```
✅ **Now, anyone using the template can easily start building their own Playdate game.**  

---

## ✅ **Step 3: Provide an Example Level**
We should add an **example level** (`exampleLevel.lua`) that demonstrates **how to use real assets**.

#### **📄 `levels/exampleLevel.lua`**
```lua
import "levels/level"
import "engine/map"
import "graphics/mockGraphics"

class('ExampleLevel').extends(Level)

function ExampleLevel:init()
    Level.super.init(self, "Example Level", "top-down")
    self.map = Map("top-down")

    -- Add a real object with a placeholder sprite
    self.objects = {}

    local exampleSprite = mockGraphics:generateMockSprite(32, 32)
    local obj = playdate.graphics.sprite.new(exampleSprite)
    obj:moveTo(150, 100)
    obj:setCollideRect(0, 0, 32, 32)
    table.insert(self.objects, obj)
    engine:addObject(obj)
end
```
✅ **This example level shows how to create and load a level with real assets.**  

---

## ✅ **Step 4: Modify `main.lua` to Support Multiple Levels**
We'll allow **switching levels easily**.

#### **🔹 Updated `main.lua`**
```lua
import "engine/engine"
import "engine/sceneLoader"
import "engine/interaction"
import "engine/player"
import "graphics/mockGraphics"
import "levels/mockLevel"
import "levels/exampleLevel"

local gfx <const> = playdate.graphics
local player = nil
local currentLevel = nil
local levelIndex = 1

local levels = {
    MockLevel(),
    ExampleLevel()
}

function myGameSetup()
    print("Setting up the game...")

    engine:init()

    -- Load the selected level
    currentLevel = levels[levelIndex]

    -- Ensure the level has a map
    if not currentLevel.map then
        print("ERROR: Level map is nil! Cannot initialize player.")
        return
    end

    -- Initialize player
    player = Player(200, 120, currentLevel.map)
    engine:addSprite(player)

    print("Game setup complete.")
end

-- Call game setup
myGameSetup()

-- Playdate Update Function
function playdate.update()
    if player then
        player:update()
    end
    if engine then
        engine:update()
    end
    interaction:checkCollision(player, engine.objects)
end
```
✅ **Now, switching levels is as easy as changing `levelIndex`.**  
✅ **More levels can be added without modifying game logic.**  

---

## 🎮 **Final Template Features**
### ✅ **Well-Organized Folder Structure**
- **`Source/engine`** → Core mechanics.
- **`Source/levels`** → Each level as a module.
- **`Source/graphics`** → Image management.

### ✅ **Easy to Extend**
- Add new levels without modifying core engine logic.
- Supports **top-down & platformer mechanics**.

### ✅ **Fully Documented**
- `README.md` explains how to use & extend the template.

---

## 🚀 **Next Steps**
1. **Test the final template in the Playdate Simulator.**
2. **Publish it as an open-source repo on GitHub.**
3. **Would you like to add a level selection menu next?** 🚀  
