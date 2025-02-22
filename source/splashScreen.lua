import "CoreLibs/graphics"

splashScreen = {}

function splashScreen:draw()
    local gfx = playdate.graphics
    gfx.clear() -- Clear the screen
    gfx.setColor(gfx.kColorWhite)

    -- Background
    playdate.display.setMosaic(10, 10) -- Set mosaic effect
    gfx.fillRect(0, 0, 400, 240)

    -- Generate finer pattern background
    for x = 0, 400, 3 do
        for y = 0, 240, 3 do
            gfx.setColor(gfx.kColorBlack)
            gfx.fillRect(x, y, 1, 1)
        end
    end

    -- Text
    gfx.setColor(gfx.kColorBlack)
    gfx.setFont(gfx.getSystemFont())
    gfx.drawTextAligned("Hit B to Start", 200, 100, kTextAlignment.center)
end
