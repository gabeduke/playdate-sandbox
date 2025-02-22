import "CoreLibs/graphics"

splashScreen = {}

function splashScreen:draw()
    local gfx = playdate.graphics
    gfx.clear() -- Clear the screen
    gfx.setColor(gfx.kColorBlack)

    -- Background
    gfx.fillRect(0, 0, 400, 240)

    -- Text
    gfx.setColor(gfx.kColorWhite)
    gfx.setFont(gfx.getSystemFont())
    gfx.drawTextAligned("Hit B to Start", 200, 100, kTextAlignment.center)
end
