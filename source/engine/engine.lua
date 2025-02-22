import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
engine = {}

function engine:init()
    print("Initializing Engine...")
    self.sprites = {}
    self.objects = {}
    self.activePlayer = nil -- ✅ Track the current player
end

function engine:setPlayer(newPlayer)
    if self.activePlayer then
        self.activePlayer:remove() -- ✅ Remove old player before setting a new one
    end
    self.activePlayer = newPlayer
end

function engine:addSprite(sprite)
    table.insert(self.sprites, sprite)
    sprite:add()
end

function engine:addObject(obj)
    if not self.objects then
        self.objects = {} -- ✅ Ensure objects table is initialized
    end
    table.insert(self.objects, obj)
    obj:add()
end

function engine:update()
    if gfx.sprite.update then
        gfx.sprite.update() -- ✅ Prevent nil update call
    end
end