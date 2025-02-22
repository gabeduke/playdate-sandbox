import "CoreLibs/object"
import "CoreLibs/graphics"
import "sceneLoader"

local gfx <const> = playdate.graphics

class('Map').extends()

function Map:init(mapType)
    self.mapType = mapType or "top-down" -- Default to top-down

    -- Load the appropriate map settings
    print("Initializing Map: " .. self.mapType)
    sceneLoader:loadMap(self.mapType)
end
