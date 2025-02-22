import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Define Platform class
class('Platform').extends(gfx.sprite)

function Platform:init(x, y, width, height)
    print("Initializing platform at position: " .. x .. ", " .. y)
    Platform.super.init(self)
    
    -- Create visible platform
    local img = gfx.image.new(width, height, gfx.kColorClear)
    gfx.pushContext(img)
        -- Make sure we're drawing in black
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, width, height)
    gfx.popContext()
    
    self:setImage(img)
    self:moveTo(x + width/2, y + height/2)
    self:setCollideRect(0, 0, width, height)
    self:setZIndex(10)  -- Ensure platforms are above background
    self:add()
    
    -- Debug print
    print("Created platform at: " .. x .. "," .. y)
end

-- Define Collectible class first
class('Collectible').extends(gfx.sprite)

function Collectible:init(x, y, type)
    print("Initializing collectible at position: " .. x .. ", " .. y .. " of type: " .. type)
    Collectible.super.init(self)
    local image = self:createCollectibleImage(type)
    self:setImage(image)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, 16, 16)
    self:setZIndex(50)
    self:add()
    print("Collectible initialized and added to sprite list.")
end

function Collectible:createCollectibleImage(type)
    local img = gfx.image.new(16, 16, gfx.kColorClear)
    gfx.pushContext(img)
        gfx.setColor(gfx.kColorBlack)
        if type == "star" then
            -- Draw a more visible star
            local points = {
                8, 0,   -- top
                10, 6,  -- right top
                16, 6,  -- right
                11, 10, -- right bottom
                13, 16, -- bottom right
                8, 12,  -- bottom middle
                3, 16,  -- bottom left
                5, 10,  -- left bottom
                0, 6,   -- left
                6, 6    -- left top
            }
            gfx.fillPolygon(table.unpack(points))
        elseif type == "triangle" then
            gfx.fillTriangle(8, 2, 2, 14, 14, 14)
        else
            gfx.fillCircleInRect(0, 0, 16, 16)
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

function Scene:init()
    print("Initializing scene...")
    -- Ensure sprite drawing is enabled
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            gfx.setColor(gfx.kColorWhite)
            gfx.fillRect(0, 0, 400, 240)
        end
    )
    
    -- Create background first
    local bgImage = self:createPlaceholderBackground()
    local bgSprite = gfx.sprite.new()
    bgSprite:setImage(bgImage)
    bgSprite:setZIndex(-1)
    bgSprite:moveTo(200, 120)
    bgSprite:add()
    print("Background created.")
    
    -- Create platforms next
    for _, p in ipairs(mockLevel.platforms) do
        print("Creating platform at: " .. p.x .. ", " .. p.y .. " with width: " .. p.width .. " and height: " .. p.height)
        Platform(p.x, p.y, p.width, p.height)  -- Corrected initialization
    end
    print("Platforms created.")
    
    -- Create collectibles last
    self:createCollectibles()
    print("Collectibles created.")
end

function Scene:createPlaceholderBackground()
    local img = gfx.image.new(400, 240, gfx.kColorClear)
    gfx.pushContext(img)
        gfx.setColor(gfx.kColorBlack)
        gfx.setLineWidth(1)
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
        print("Creating collectible at: " .. item.x .. ", " .. item.y .. " of type: " .. item.type)
        local collectible = Collectible(item.x, item.y, item.type)  -- Corrected initialization
        collectible:setZIndex(50)  -- Above platforms, below player
    end
end
