-- main.lua
-- entry point for the Love2d game engine
-- require "src.tiledmap"
require "src.aeroplane"
require "src.map"

keyPressed = {}

--- entities who wish to be notified when a key is pressed
keyPressedHandlers = {}

--- entities whose models should be updated every game tick
activeEntities = {}

-- this needs to be in conf.lua
-- function love.conf(t)
-- end

function love.load()
   --love system settings (window settings, etc)
   
   --load all assets

   --TiledMap code needs to be moved to its own entity
   -- TiledMap_Load("assets/hyrule-world.tmx")
   -- gCamX,gCamY = gMapWidth * gTileWidth / 2, gMapHeight * gTileHeight / 2
   aeroplane.load()
   map.load()
   map.setTarget(aeroplane)
   
   table.insert(activeEntities, aeroplane)
   table.insert(keyPressedHandlers, aeroplane)
   
   
end

--update the game model
function love.update(dt)
   for key, value in pairs(activeEntities) do
      value:update(dt)
   end
   
end

--update the view based on changes from the model
function love.draw()
   -- should limit to visible entities. ya should be done here since we know where the window is.
   for key, value in pairs(activeEntities) do
      value:draw()
   end
   
end

function love.keypressed(key, isrepeat)
   keyPressed[key] = true
   if key == "escape" then
      os.exit(0)
   end

   -- should this be a loop? is there a better way of sending commands out to the eititiy(s) that the player controls?
   for key, value in pairs(keyPressedHandlers) do
      value:keypressed(key, isrepeat)
   end
   
end

function love.keyreleased(key)
   keyPressed[key] = false
end
