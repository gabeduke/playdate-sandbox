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
    -- Initialize graphics
    gfx.setBackgroundColor(gfx.kColorWhite)
    gfx.clear() -- Clear to background color
    
    -- Create scene and player
    currentScene = Scene.new()
    player = Player.new(200, 120)
    
    -- Debug info
    print("Game initialized!")
end

function playdate.update()
    -- Update sprites and redraw screen
    gfx.sprite.redrawBackground()
    gfx.sprite.update()
    
    -- Draw debug grid
    for x = 0, 400, 40 do
        gfx.drawLine(x, 0, x, 240)
    end
    for y = 0, 240, 40 do
        gfx.drawLine(0, y, 400, y)
    end
    
    -- Draw UI
    if player then
        gfx.drawTextAligned("Collect: " .. player.collectibles, 340, 20, kTextAlignment.right)
    end
    
    pd.timer.updateTimers()
end
