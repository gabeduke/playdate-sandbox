local gfx <const> = playdate.graphics
mockGraphics = {}

function mockGraphics:generateMockBackground(width, height)
    local gfx = playdate.graphics
    local img = gfx.image.new(width, height)

    gfx.pushContext(img)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(0, 0, width, height) -- ✅ Ensure a solid background first
        
        gfx.setColor(gfx.kColorBlack)
        
        -- ✅ Draw a checkered pattern
        for y = 0, height, 20 do
            for x = 0, width, 20 do
                if (x // 20 + y // 20) % 2 == 0 then
                    gfx.fillRect(x, y, 10, 10)
                end
            end
        end
    gfx.popContext()

    return img
end


function mockGraphics:generateMockSprite(width, height)
    print("Generating mock sprite of size", width, height)
    local img = gfx.image.new(width, height)

    gfx.pushContext(img)
    gfx.drawRect(0, 0, width, height)  -- Simple outlined square
    gfx.fillRect(5, 5, width - 10, height - 10) -- Smaller filled square
    gfx.popContext()

    return img
end

-- 🎨 Effects Module
mockGraphics.effects = {}

function mockGraphics.effects:applyDither(image)
    local effectImage = gfx.image.new(image:getSize())
    gfx.pushContext(effectImage)
    image:drawFaded(0, 0, 0.5, gfx.image.kDitherTypeDiagonalLine)
    gfx.popContext()
    return effectImage
end

function mockGraphics.effects:applyInvert(image)
    local effectImage = gfx.image.new(image:getSize())
    gfx.pushContext(effectImage)
    image:draw(0, 0, gfx.kDrawModeInverted)
    gfx.popContext()
    return effectImage
end

function mockGraphics.effects:applyBlur(image)
    local effectImage = gfx.image.new(image:getSize())
    gfx.pushContext(effectImage)
    image:blurredImage(2):draw(0, 0)
    gfx.popContext()
    return effectImage
end

return mockGraphics
