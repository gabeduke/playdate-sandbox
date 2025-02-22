import "gameState"

interaction = {}

function interaction:checkCollision(player, objects)
    if not player or not objects then return end

    for _, obj in ipairs(objects) do
        if player:overlappingSprites(obj) then
            local objID = tostring(obj) -- Unique ID for the object

            if not gameState:isItemCollected(objID) then
                gameState:collectItem(objID)
                obj:remove() -- ✅ Remove the object upon collection
            end
        end
    end
end
