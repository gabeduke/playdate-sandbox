local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Game objects
local fallingArt = {}
local artImages = {}

function initializeGame()
    -- Load art images from assets folder
    -- Note: You'll need to add .png files to assets/art/ folder
    local artFiles = playdate.file.listFiles("assets/art")
    for _, file in ipairs(artFiles or {}) do
        if file:sub(-4) == ".png" then
            local img = gfx.image.new("assets/art/" .. file)
            if img then
                table.insert(artImages, img)
            end
        end
    end
    
    -- Start spawning art
    pd.timer.performAfterDelay(2000, spawnArt)
end

function spawnArt()
    if #artImages > 0 then
        local art = {
            x = math.random(32, 368),
            y = -32,
            speed = math.random(2, 4),
            image = artImages[math.random(1, #artImages)]
        }
        table.insert(fallingArt, art)
    end
    
    -- Schedule next spawn
    pd.timer.performAfterDelay(2000, spawnArt)
end

function updateFallingArt()
    for i = #fallingArt, 1, -1 do
        local art = fallingArt[i]
        art.y = art.y + art.speed
        
        if art.image then
            art.image:drawCentered(art.x, art.y)
        end
        
        -- Remove if off screen
        if art.y > 240 then
            table.remove(fallingArt, i)
        end
    end
end

function drawPlayer(x, y)
    gfx.fillRect(x - 16, y - 8, 32, 16)
end
