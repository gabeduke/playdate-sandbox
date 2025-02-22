import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y, map)
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
    self:setZIndex(100)

    -- Assign movement mode based on the map type
    self.mapType = map.mapType
    if self.mapType == "side" then
        self.gravity = 0.3
        self.jumpForce = -5
        self.isGrounded = false
        self.controlMode = "crank-speed" -- In platformers, crank sets speed
    else
        self.gravity = 0
        self.jumpForce = 0
        self.isGrounded = true
        self.controlMode = "crank-direction" -- In top-down, crank sets direction
    end

    self.speed = 2
    self.dx = 0
    self.dy = 0

    self:add()
    print("Player initialized with control mode: " .. self.controlMode)
end

function Player:update()
    local crankChange = pd.getCrankChange()

    if self.mapType == "side" then
        -- D-pad movement
        if pd.buttonIsPressed(pd.kButtonLeft) then
            self.dx = -self.speed
        elseif pd.buttonIsPressed(pd.kButtonRight) then
            self.dx = self.speed
        else
            self.dx = 0
        end
    
        -- Crank controls jumping force
        if math.abs(crankChange) > 1 then
            self.jumpForce = -3 + (crankChange * -0.05)
        end
    
        -- Jumping with A button
        if pd.buttonJustPressed(pd.kButtonA) and self.isGrounded then
            self.dy = self.jumpForce
            self.isGrounded = false
        end
    
        -- Gravity
        self.dy = self.dy + self.gravity
    end

    if self.mapType == "top-down" then
        -- More responsive movement
        local crankPosition = pd.getCrankPosition()
        self.dx = math.cos(math.rad(crankPosition)) * self.speed
        self.dy = math.sin(math.rad(crankPosition)) * self.speed
    
        -- D-pad overrides crank movement
        if pd.buttonIsPressed(pd.kButtonLeft) then
            self.dx = -self.speed
        elseif pd.buttonIsPressed(pd.kButtonRight) then
            self.dx = self.speed
        end
        if pd.buttonIsPressed(pd.kButtonUp) then
            self.dy = -self.speed
        elseif pd.buttonIsPressed(pd.kButtonDown) then
            self.dy = self.speed
        end
    end
    

    -- Apply movement
    local nextX = self.x + (self.dx * self.speed)
    local nextY = self.y + self.dy

    -- Keep player inside screen boundaries
    local screenWidth, screenHeight = 400, 240
    nextX = math.max(10, math.min(nextX, screenWidth - 10))
    nextY = math.max(10, math.min(nextY, screenHeight - 10))

    self:moveWithCollisions(nextX, nextY)
end

function Player:collisionResponse(other)
    if other:isa(Platform) then
        if self.dy > 0 then
            self.isGrounded = true
        end
        self.dy = 0
        return "slide"
    elseif other:isa(Collectible) then
        other:collect()
        return "overlap"
    end
    return "slide"
end
