local pd <const> = playdate
local gfx <const> = playdate.graphics

import "scene"  -- This gives us access to the Collectible class

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    -- Call super constructor first
    Player.super.init(self)
    
    -- Create placeholder player image if asset doesn't exist
    local playerImage = self:createPlaceholderPlayer()
    self:setImage(playerImage)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, self:getSize())
    self:add()  -- Add sprite to the display list
    
    self.speed = 3
    self.collectibles = 0
end

function Player:createPlaceholderPlayer()
    local img = gfx.image.new(32, 32)
    gfx.pushContext(img)
        -- Draw player with visible collision box
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(4, 4, 24, 24)
        -- Add direction indicator
        gfx.drawTriangle(16, 4, 28, 16, 16, 28)
    gfx.popContext()
    return img
end

-- Add debug drawing
function Player:draw()
    Player.super.draw(self)
    -- Draw collision boundary
    gfx.setColor(gfx.kColorBlack)
    local x, y, w, h = self:getCollideRect()
    gfx.drawRect(x, y, w, h)
end

function Player:update()
    local dx, dy = 0, 0
    
    if pd.buttonIsPressed(pd.kButtonLeft) then
        dx = -self.speed
    elseif pd.buttonIsPressed(pd.kButtonRight) then
        dx = self.speed
    end
    
    if pd.buttonIsPressed(pd.kButtonUp) then
        dy = -self.speed
    elseif pd.buttonIsPressed(pd.kButtonDown) then
        dy = self.speed
    end
    
    -- Constrain player to screen bounds
    local newX = math.max(16, math.min(384, self.x + dx))
    local newY = math.max(16, math.min(224, self.y + dy))
    
    local actualX, actualY, collisions = self:moveWithCollisions(newX, newY)
    
    -- Handle collisions with collectibles
    for _, collision in ipairs(collisions) do
        if collision.other and collision.other:isa(Collectible) then
            collision.other:collect()
            self.collectibles += 1
        end
    end
end
