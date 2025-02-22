local interaction = {}

function interaction:checkCollision(player, objects)
    for _, obj in ipairs(objects) do
        if player:overlappingSprites(obj) then
            -- TODO: Handle item collection logic
            print("Collected item:", obj)
        end
    end
end

return interaction
