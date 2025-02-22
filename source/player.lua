import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "scene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    print("Initializing player at position: " .. x .. ", " .. y)
    Player.super.init(self)
    
    -- Create player sprite
    local playerSize = 20
    local img = gfx.image.new(playerSize, playerSize, gfx.kColorClear)
    gfx.pushContext(img)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(0, 0, playerSize, playerSize, 4)
    gfx.popContext()
    
    self:setImage(img)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, playerSize, playerSize)
    self:setZIndex(100)  -- Ensure player is above everything

    -- Make sure to add the sprite
    self:add()
    print("Player initialized and added to sprite list.")
end

function Player:update()
    local crankChange = pd.getCrankChange()
    
    -- Basic horizontal movement
    if pd.buttonIsPressed(pd.kButtonLeft) then
        self.dx = -self.speed
        print("Moving left with speed: " .. self.speed)
    elseif pd.buttonIsPressed(pd.kButtonRight) then
        self.dx = self.speed
        print("Moving right with speed: " .. self.speed)
    else
        self.dx = 0
    end
    
    -- Apply gravity and jumping
    if pd.buttonJustPressed(pd.kButtonA) and self.isGrounded then
        self.dy = self.jumpForce
        self.isGrounded = false
        print("Jumping with force: " .. self.jumpForce)
    end
    
    self.dy = self.dy + self.gravity
    print("Applying gravity: " .. self.gravity .. ", New dy: " .. self.dy)
    
    -- Move and check collisions
    local nextX = self.x + self.dx
    local nextY = self.y + self.dy
    print("Next position: (" .. nextX .. ", " .. nextY .. ")")
    
    -- Actually move the sprite
    self:moveWithCollisions(nextX, nextY)
end

function Player:collisionResponse(other)
    if other:isa(Platform) then
        -- Basic platform collision
        if self.dy > 0 then
            self.isGrounded = true
            print("Landed on platform, setting isGrounded to true")
        end
        self.dy = 0
        return "slide"
    elseif other:isa(Collectible) then
        other:collect()
        print("Collected an item")
        return "overlap"
    end
    return "slide"
end
