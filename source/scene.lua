local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Define Collectible class first
class('Collectible').extends(gfx.sprite)

function Collectible:init(x, y, type)
    local image = self:createCollectibleImage(type)
    self:setImage(image)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, 16, 16)
    self:add()
end

function Collectible:createCollectibleImage(type)
    local img = gfx.image.new(16, 16)
    gfx.pushContext(img)
        if type == "star" then
            -- Draw a simple star shape
            gfx.drawCircle(8, 8, 8)
            gfx.drawLine(4, 8, 12, 8)
            gfx.drawLine(8, 4, 8, 12)
        elseif type == "triangle" then
            -- Draw triangle
            gfx.drawTriangle(8, 2, 2, 14, 14, 14)
        else
            -- Default circle
            gfx.drawCircleInRect(0, 0, 16, 16)
        end
    gfx.popContext()
    return img
end

function Collectible:collect()
    self:remove()
end

-- Define Scene class
class('Scene').extends()

function Scene.new()
    local scene = Scene()
    
    -- Create background sprite
    local bgImage = scene:createPlaceholderBackground()
    local bgSprite = gfx.sprite.new()
    bgSprite:setImage(bgImage)
    bgSprite:setZIndex(-1)
    bgSprite:moveTo(200, 120)
    bgSprite:add()
    
    scene:createCollectibles()
    return scene
end

function Scene:createPlaceholderBackground()
    local img = gfx.image.new(400, 240)
    gfx.pushContext(img)
        -- Draw a more visible background
        gfx.setDitherPattern(0.5)
        gfx.fillRect(0, 0, 400, 240)
        
        -- Draw some platform-like elements
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(50, 180, 300, 20)
        gfx.fillRect(100, 120, 200, 20)
        gfx.fillRect(150, 60, 100, 20)
        
        -- Add some decorative elements
        gfx.drawCircleInRect(180, 30, 40, 40)
        gfx.drawRect(300, 100, 50, 50)
    gfx.popContext()
    return img
end

function Scene:createCollectibles()
    -- Create collectibles in interesting placeholder positions
    local points = {
        {x = 100, y = 100, type = "star"},
        {x = 300, y = 150, type = "circle"},
        {x = 200, y = 80, type = "triangle"}
    }
    
    for _, point in ipairs(points) do
        Collectible.new(point.x, point.y, point.type)
    end
end
