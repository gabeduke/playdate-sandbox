import "levels/topDownLevel"
import "levels/sideViewLevel"

levelSelector = {}

levelSelector.levels = {
    {name = "Top-Down Level", instance = nil},
    {name = "Side-View Level", instance = nil}
}

levelSelector.currentIndex = 1

function levelSelector:cleanupLevel()
    -- ✅ Remove all objects before switching levels
    if engine.objects then
        for _, obj in ipairs(engine.objects) do
            obj:remove()
        end
        engine.objects = {}
    end

    -- ✅ Remove old player
    if player then
        player:remove()
        player = nil
    end

    -- ✅ Remove previous level’s background
    playdate.graphics.sprite.setBackgroundDrawingCallback(
        function()
            -- Prevent nil callback errors
        end
    )
end




function levelSelector:selectLevel(index)
    -- ✅ Cleanup previous level before switching
    self:cleanupLevel()

    self.currentIndex = index
    if not self.levels[index].instance then
        self.levels[index].instance = index == 1 and TopDownLevel() or SideViewLevel()
    end
    return self.levels[index].instance
end

function levelSelector:getCurrentLevel()
    return self:selectLevel(self.currentIndex)
end
