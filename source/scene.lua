local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Define Platform class
class('Platform').extends(gfx.sprite)

function Platform:init(x, y, width, height)
    Platform.super.init(self)
    
    -- Create visible platform
    local img = gfx.image.new(width, height)
    gfx.pushContext(img)
        -- Make sure we're drawing in black
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, width, height)
    gfx.popContext()
    
    self:setImage(img)
    self:moveTo(x + width/2, y + height/2)
    self:setCollideRect(0, 0, width, height)
    self:add()
    
    -- Debug print
    print("Created platform at: " .. x .. "," .. y)
end

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

-- Add mock level data
local mockLevel = {
    platforms = {
        {x = 50, y = 200, width = 300, height = 20},   -- ground
        {x = 100, y = 140, width = 200, height = 20},  -- middle
        {x = 150, y = 80, width = 100, height = 20},   -- top
    },
    collectibles = {
        {x = 75, y = 160, type = "star"},
        {x = 200, y = 100, type = "triangle"},
        {x = 300, y = 60, type = "circle"}
    }
}

function Scene.new()
    local scene = Scene()
    
    -- Create background first
    local bgImage = scene:createPlaceholderBackground()
    local bgSprite = gfx.sprite.new()
    bgSprite:setImage(bgImage)
    bgSprite:setZIndex(-1)
    bgSprite:moveTo(200, 120)
    bgSprite:add()
    
    -- Create platforms next
    for _, p in ipairs(mockLevel.platforms) do
        Platform.new(p.x, p.y, p.width, p.height)
    end
    
    -- Create collectibles last
    scene:createCollectibles()
    
    return scene
end

function Scene:createPlaceholderBackground()
    local img = gfx.image.new(400, 240)
    gfx.pushContext(img)
        -- Draw a light grid pattern
        for x = 0, 400, 40 do
            gfx.drawLine(x, 0, x, 240)
        end
        for y = 0, 240, 40 do
            gfx.drawLine(0, y, 400, y)
        end
    gfx.popContext()
    return img
end

function Scene:createCollectibles()
    for _, item in ipairs(mockLevel.collectibles) do
        local collectible = Collectible.new(item.x, item.y, item.type)
        collectible:setZIndex(50)  -- Above platforms, below player
    end
end
