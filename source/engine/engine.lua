import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "engine/sceneLoader"

local gfx <const> = playdate.graphics
engine = {}

function engine:init()
    print("Initializing Engine...")
    self.sprites = {}
    self.objects = {} -- New: Tracks objects for collision
end

function engine:addSprite(sprite)
    table.insert(self.sprites, sprite)
    sprite:add()
end

function engine:addObject(obj)
    table.insert(self.objects, obj)
    obj:add()
end

-- function engine:update()
--     gfx.sprite.update()
-- end

function engine:update()
    -- Slow down logs by only printing every second
    if not self.lastLogTime or playdate.getElapsedTime() - self.lastLogTime >= 1 then
        print("Updating game...")
        self.lastLogTime = playdate.getElapsedTime()
    end

    playdate.timer.updateTimers() -- Keep timers running
    gfx.sprite.update()
end
