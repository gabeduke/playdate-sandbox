import "engine/engine"
import "engine/sceneLoader"
import "engine/interaction"
import "engine/player"
import "graphics/mockGraphics"
import "levelSelector"
import "splashScreen"

local gfx <const> = playdate.graphics
local player = nil
local currentLevel = nil
local gameStarted = false -- ✅ Start with splash screen

function myGameSetup()
    print("Setting up the game...")
    engine:init()

    -- Select a level
    currentLevel = levelSelector:getCurrentLevel()

    -- ✅ Ensure level has a name before calling `drawUI()`
    if not currentLevel.name then
        currentLevel.name = "Unnamed Level"
        print("WARNING: Level name was nil. Defaulting to 'Unnamed Level'.")
    end

    -- ✅ Remove old player before creating a new one
    if player then
        player:remove()
    end

    -- Initialize new player
    player = Player(200, 120, currentLevel.map)
    engine:setPlayer(player)
    engine:addSprite(player)

    print("Game setup complete. Current Level: " .. currentLevel.name)
end

local function drawUI()
    if not currentLevel or not currentLevel.name then
        return -- ✅ Prevent nil errors
    end

    local levelName = currentLevel.name or "Unknown"

    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 400, 20) -- Background for text

    gfx.setColor(gfx.kColorWhite)

    -- ✅ Ensure Playdate's default font is used
    local font = gfx.getSystemFont()
    if font then
        gfx.setFont(font)
    else
        print("ERROR: Failed to load system font!")
    end

    gfx.drawText("Level: " .. levelName, 10, 5)
end


function playdate.update()
    gfx.sprite.update()

    if gameStarted then
        if drawUI then -- ✅ Check if `drawUI` exists before calling it
            drawUI()
        else
            print("ERROR: drawUI is nil!")
        end
    else
        splashScreen:draw()
    end
end

-- ✅ Start the game when B is pressed
function playdate.BButtonDown()
    if not gameStarted then
        print("Game Starting!")
        gameStarted = true
        myGameSetup()
    else
        print("Switching levels...")
        playdate.stop() -- ✅ Stop the engine before switching levels
        local newIndex = (levelSelector.currentIndex % #levelSelector.levels) + 1
        levelSelector:cleanupLevel()
        currentLevel = levelSelector:selectLevel(newIndex)
        myGameSetup()
        playdate.start() -- ✅ Restart game loop
    end
end
