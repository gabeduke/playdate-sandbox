gameState = {
    collectedItems = {}, -- Track collected objects
    triggersActivated = {} -- Track triggered events
}

function gameState:collectItem(itemID)
    if not self.collectedItems[itemID] then
        self.collectedItems[itemID] = true
        print("Collected item: " .. itemID)
    end
end

function gameState:isItemCollected(itemID)
    return self.collectedItems[itemID] == true
end

function gameState:activateTrigger(triggerID)
    if not self.triggersActivated[triggerID] then
        self.triggersActivated[triggerID] = true
        print("Trigger activated: " .. triggerID)
    end
end

function gameState:isTriggerActivated(triggerID)
    return self.triggersActivated[triggerID] == true
end
