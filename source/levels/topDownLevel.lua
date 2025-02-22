import "levels/level"
import "engine/map"
import "graphics/mockGraphics"

class('TopDownLevel').extends(Level)

function TopDownLevel:init()
    Level.super.init(self, "Top-Down Level", "top-down")
    self.map = Map("top-down")
    self.objects = {}
    self.triggers = {}

    -- Create collectible items
    for i = 1, 3 do
        local objImage = mockGraphics:generateMockSprite(16, 16)
        local obj = playdate.graphics.sprite.new(objImage)
        obj:moveTo(math.random(50, 350), math.random(50, 200))
        obj:setCollideRect(0, 0, 16, 16)
        obj:add() -- ✅ Ensure it is added as a sprite
        table.insert(self.objects, obj)
        engine:addObject(obj)
    end

    -- Create a door trigger
    local doorImage = mockGraphics:generateMockSprite(24, 24)
    local door = playdate.graphics.sprite.new(doorImage)
    door:moveTo(350, 120)
    door:setCollideRect(0, 0, 24, 24)
    door.isDoor = true
    door.targetX, door.targetY = 50, 50 -- ✅ Move player here when triggered
    door:add() -- ✅ Ensure door is added as a sprite

    table.insert(self.triggers, door)
    engine:addObject(door)
end
