import "engine/engine"
import "engine/sceneLoader"
import "engine/interaction"
import "engine/player"
import "graphics/mockGraphics"
import "levels/mockLevel"

local gfx <const> = playdate.graphics
local player = nil
local currentLevel = nil

function myGameSetup()
    print("Setting up the game...")

    engine:init()

    -- Load the mock level
    currentLevel = MockLevel()

    -- Initialize player with the selected level’s map
    player = Player(200, 120, currentLevel.map)
    engine:addSprite(player)

    print("Game setup complete.")
end

-- Call game setup
myGameSetup()

-- Playdate Update Function
function playdate.update()
    player:update()
    interaction:checkCollision(player, engine.objects)
    engine:update()
end
