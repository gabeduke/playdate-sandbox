import "graphics/mockGraphics"

local gfx <const> = playdate.graphics -- ✅ Ensure `gfx` is defined

sceneLoader = {}

function sceneLoader:loadMap(mapType)
    self:clearBackground()
    self:clearObjects() -- Clear existing objects before loading new ones
    self:loadObjects(5) -- Load objects when a new map is loaded

    if mapType == "top-down" then
        print("Loading top-down map...")
        self:loadTopDownMap()
    else
        print("Loading side-view map...")
        self:loadSideMap()
    end
end

function sceneLoader:clearBackground()
    playdate.graphics.sprite.setBackgroundDrawingCallback(
        function()
            playdate.graphics.clear(playdate.graphics.kColorWhite)
        end
    )
end

function sceneLoader:loadTopDownMap()
    print("Generating top-down checkered background...")
    local backgroundImage = self:generateMockBackground(400, 240)

    playdate.graphics.sprite.setBackgroundDrawingCallback(
        function()
            backgroundImage:draw(0, 0)
        end
    )
end

function sceneLoader:loadSideMap()
    print("Generating side-view mock background...")
    local backgroundImage = self:generateMockBackground(400, 240)

    gfx.pushContext(backgroundImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 200, 400, 5) -- ✅ Adds a dark "ground" area
    gfx.popContext()

    playdate.graphics.sprite.setBackgroundDrawingCallback(
        function()
            backgroundImage:draw(0, 0)
        end
    )
end

function sceneLoader:generateMockBackground(width, height)
    local backgroundImage = gfx.image.new(width, height)
    gfx.pushContext(backgroundImage)
    
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, width, height)
    
    -- Generate unique mosaic pattern
    for x = 0, width, 3 do
        for y = 0, height, 3 do
            gfx.setColor(gfx.kColorBlack)
            gfx.fillRect(x, y, 1, 1)
        end
    end
    
    gfx.popContext()
    return backgroundImage
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

function sceneLoader:clearObjects()
    local allSprites = playdate.graphics.sprite.getAllSprites()
    for _, sprite in ipairs(allSprites) do
        sprite:remove()
    end
end
