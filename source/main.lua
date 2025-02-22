import "engine"
import "sceneLoader"
import "interaction"
import "mockGraphics"

local gfx <const> = playdate.graphics
local player = nil

function myGameSetup()
    print("Setting up the game...")

    -- Initialize engine
    engine:init()

    -- Generate a mock background
    sceneLoader:loadBackground()

    -- Create a mock player sprite
    local originalSprite = mockGraphics:generateMockSprite(32, 32)

    -- Apply a random effect
    local playerImage = originalSprite
    local effectType = math.random(1, 3)  -- Randomly apply an effect

    if effectType == 1 then
        playerImage = mockGraphics.effects:applyDither(originalSprite)
        print("Applied Dither Effect!")
    elseif effectType == 2 then
        playerImage = mockGraphics.effects:applyInvert(originalSprite)
        print("Applied Invert Effect!")
    elseif effectType == 3 then
        playerImage = mockGraphics.effects:applyBlur(originalSprite)
        print("Applied Blur Effect!")
    end

    player = gfx.sprite.new(playerImage)
    player:moveTo(200, 120)
    engine:addSprite(player)

    print("Game setup complete.")
end

-- Call game setup
myGameSetup()

-- Function to handle player movement
function updatePlayerMovement()
    local speed = 2  -- Adjust movement speed

    if playdate.buttonIsPressed(playdate.kButtonUp) then
        player:moveBy(0, -speed)
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        player:moveBy(0, speed)
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        player:moveBy(-speed, 0)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        player:moveBy(speed, 0)
    end
end

-- Playdate Update Function
function playdate.update()
    updatePlayerMovement()
    engine:update()
end
