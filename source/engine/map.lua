import "CoreLibs/object"
import "CoreLibs/graphics"
import "engine/sceneLoader"

local gfx <const> = playdate.graphics

class('Map').extends()

function Map:init(mapType)
    self.mapType = mapType or "top-down"  -- ✅ Default to top-down if nil

    -- ✅ Ensure mapType is correctly assigned
    if not self.mapType then
        print("ERROR: Map type is nil!")
        return
    end

    -- Load the appropriate map settings
    print("Initializing Map: " .. self.mapType)
    sceneLoader:loadMap(self.mapType)
end
