import "levels/level"
import "engine/map"
import "graphics/mockGraphics"

class('SideViewLevel').extends(Level)

function SideViewLevel:init()
    Level.super.init(self, "Side-View Level", "side") -- ✅ Ensure the name is properly set
    self.map = Map("side")

    -- Platforms
    self.objects = {}

    for i = 1, 3 do
        local platformImage = mockGraphics:generateMockSprite(80, 10)
        local platform = playdate.graphics.sprite.new(platformImage)
        platform:moveTo(math.random(50, 350), math.random(100, 200))
        platform:setCollideRect(0, 0, 80, 10)
        platform:add()
        table.insert(self.objects, platform)
        engine:addObject(platform)
    end
end
