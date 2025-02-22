import "mockGraphics"

local gfx <const> = playdate.graphics

sceneLoader = {}

function sceneLoader:loadBackground()
    print("Generating mock background...")

    -- Generate a placeholder background
    local backgroundImage = mockGraphics:generateMockBackground(400, 240)

    gfx.sprite.setBackgroundDrawingCallback(
        function()
            backgroundImage:draw(0, 0)
        end
    )

    print("Mock background generated successfully!")
end
