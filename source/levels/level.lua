import "CoreLibs/object"
import "CoreLibs/graphics"
import "engine/map"
import "engine/sceneLoader"

local gfx <const> = playdate.graphics

class('Level').extends()

function Level:init(levelName, mapType)
    self.levelName = levelName or "Mock Level"
    self.map = Map(mapType) -- Every level has a map
    self.objects = {}  -- Ensure self.objects is initialized
    
    print("Loading level: " .. self.levelName)
    self:loadAssets()
end

function Level:loadAssets()
    print("Loading assets for " .. self.levelName)

    -- Load background based on map type
    sceneLoader:loadMap(self.map.mapType)

    -- Load mock objects (to be replaced with real assets later)
    for i = 1, 5 do
        local objImage = mockGraphics:generateMockSprite(16, 16)
        local obj = gfx.sprite.new(objImage)
        obj:moveTo(math.random(50, 350), math.random(50, 200))
        obj:setCollideRect(0, 0, 16, 16)
        table.insert(self.objects, obj)
        engine:addObject(obj)
    end
end

function Level:getMapType()
    return self.map.mapType
end

function Level:getObjects()
    return self.objects
end
