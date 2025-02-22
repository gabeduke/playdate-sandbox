import "gameState"

trigger = {}

function trigger:activate(player, triggers)
    if not player or not triggers then return end

    for _, trg in ipairs(triggers) do
        if player:overlappingSprites(trg) then
            local triggerID = tostring(trg)

            if not gameState:isTriggerActivated(triggerID) then
                gameState:activateTrigger(triggerID)

                -- ✅ If it's a door, teleport the player
                if trg.isDoor then
                    print("Door activated! Teleporting player to", trg.targetX, trg.targetY)
                    player:moveTo(trg.targetX, trg.targetY)
                end
            end
        end
    end
end
