import "CoreLibs/object"
import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

class('Interaction').extends()

function Interaction:checkCollision(player, objects)
    for _, obj in ipairs(objects) do
        if player:overlapping(obj) then
            print("Collision detected with object at: " .. obj.x .. ", " .. obj.y)
        end
    end
end
