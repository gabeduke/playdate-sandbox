import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

-- Ensure engine is a global variable
engine = {}

function engine:init()
    print("Initializing Engine...")
    self.sprites = {}
    self.items = {}
end

function engine:addSprite(sprite)
    if sprite then
        table.insert(self.sprites, sprite)
        sprite:add()
        print("Added a sprite!")
    else
        print("Error: Trying to add nil sprite!")
    end
end

function engine:update()
    -- Slow down logs by only printing every second
    if not self.lastLogTime or playdate.getElapsedTime() - self.lastLogTime >= 1 then
        print("Updating game...")
        self.lastLogTime = playdate.getElapsedTime()
    end

    playdate.timer.updateTimers() -- Keep timers running
    gfx.sprite.update()
end
