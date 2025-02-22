import "graphics/mockGraphics"

sceneLoader = {}

function sceneLoader:loadMap(mapType)
    if mapType == "top-down" then
        print("Loading top-down map...")
        self:loadTopDownMap()
    else
        print("Loading side-view map...")
        self:loadSideMap()
    end
end

function sceneLoader:loadTopDownMap()
    print("Generating top-down mock background...")
    local backgroundImage = mockGraphics:generateMockBackground(400, 240)
    playdate.graphics.sprite.setBackgroundDrawingCallback(
        function()
            backgroundImage:draw(0, 0)
        end
    )
end

function sceneLoader:loadSideMap()
    print("Generating side-view mock background...")
    local backgroundImage = mockGraphics:generateMockBackground(400, 240)
    playdate.graphics.sprite.setBackgroundDrawingCallback(
        function()
            backgroundImage:draw(0, 0)
        end
    )
end

-- Standardized object loading (optional, useful for procedural levels)
function sceneLoader:loadObjects(objectCount)
    local objects = {}
    local gridSize = 20  -- Align objects on a subtle grid

    for i = 1, objectCount or 5 do
        local objImage = mockGraphics:generateMockSprite(16, 16)
        local obj = playdate.graphics.sprite.new(objImage)
        local x, y = math.random(50, 350) // gridSize * gridSize, math.random(50, 200) // gridSize * gridSize
        obj:moveTo(x, y)
        obj:setCollideRect(0, 0, 16, 16)
        table.insert(objects, obj)
        engine:addObject(obj)
    end

    print(objectCount .. " objects loaded.")
    return objects
end
