import "levels/level"
import "engine/map"
import "graphics/mockGraphics"
import "engine/sceneLoader"

class('MockLevel').extends(Level)

function MockLevel:init()
    Level.super.init(self, "Mock Level", "top-down")  -- ✅ Ensure the correct map type is passed

    -- ✅ Properly initialize the map
    self.map = Map("top-down") 

    -- ✅ Initialize objects as an empty table
    self.objects = {}

    -- Mock objects
    print("Generating mock objects...")
    for i = 1, 5 do
        local objImage = mockGraphics:generateMockSprite(16, 16)
        local obj = playdate.graphics.sprite.new(objImage)
        obj:moveTo(math.random(50, 350), math.random(50, 200))
        obj:setCollideRect(0, 0, 16, 16)
        table.insert(self.objects, obj)  -- ✅ Now `self.objects` exists, so no error!
        engine:addObject(obj)
    end
end
