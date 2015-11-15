-- main.lua
-- entry point for the Love2d game engine
require "src.aeroplane"
require "src.map"

--- entities who wish to be notified when a key is pressed
keyPressedHandlers = {}

--- entities whose models should be updated every game tick
activeEntities = {}

maps = {}
activeMap = nil

function love.load()
   --love system settings (window settings, etc)
   
   --load all assets

   -- the active map will replace the active entities table
   -- all callbacks will get passed to the active map
   -- somewhat like the concept of scenes, the active map manages EVERYTHING WITH ACTIVE ENTITIES
   maps.world = map
   maps.world.load()

   maps.world.addTarget(aeroplane)

   activeMap = maps.world

end

--update the game model
function love.update(dt)
   activeMap.update(dt)
   
end

--update the view based on changes from the model
function love.draw()
   -- should limit to visible entities. ya should be done here since we know where the window is.
   activeMap.draw()
   
end

function love.keypressed(key, isrepeat)
   -- Global handlers
   if key == "escape" then
      os.exit(0)
   end

   -- Game handlers
   activeMap.keypressed(key, isrepeat)
end

function love.keyreleased(key)
   -- Global handlers
   
   -- Game handlers
   activeMap.keyreleased(key)
   
end
