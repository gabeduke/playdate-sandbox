-- Below is a small example program where you can move a circle
-- around with the crank. You can delete everything in this file,
-- but make sure to add back in a playdate.update function since
-- one is required for every Playdate game!
-- =============================================================

-- Importing libraries used for drawCircleAtPoint and crankIndicator
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "scene"
import "player"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Initialize game components
local currentScene
local player

-- Initialize game
function playdate.init()
    -- Initialize display
    gfx.setBackgroundColor(gfx.kColorWhite)
    
    -- Create scene (this creates background, platforms, and collectibles)
    currentScene = Scene.new()
    
    -- Create player last (so it's on top)
    player = Player.new(200, 120)
    player:setZIndex(100)
    
    -- Print initial sprite count for debugging
    print("Initial sprite count: " .. #gfx.sprite.getAllSprites())
end

function playdate.update()
    -- Clear the screen properly
    gfx.clear(gfx.kColorWhite)
    
    -- Force redraw background
    gfx.sprite.redrawBackground()
    
    -- Update and draw all sprites
    gfx.sprite.update()
    
    -- Debug info on top
    gfx.setColor(gfx.kColorBlack)
    gfx.drawText("Sprites: " .. #gfx.sprite.getAllSprites(), 5, 5)
    
    -- Update timers
    pd.timer.updateTimers()
end
