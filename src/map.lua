local P = {}
setmetatable(P, {__index = _G})
map = P
setfenv(1, P)

local sti = require "lib.Simple-Tiled-Implementation"

local map = nil
local camX = 400
local camY = 400
local target = nil

-- explicit key shared between the tables. Starts at one because lua is fucking retarded.
local entKey = 1
local entities = {}
local layers = {}

---- model ----
--- Load the map and initializa all the things in the world
-- @return nil
function load()
   windowWidth  = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   map = sti.new("assets/hyrule-world.lua")
   -- I feel like we shouldn't handle loading entities. They should be passed to us.
   -- You never know who you'll want in a scene/world.
end

--- update our camera location based on the target's x and y
function update(dt)
   -- TODO handle nil
   camX = target.x
   camY = target.y
   for k, e in pairs(entities) do
      e.update(dt)
   end
   
end

---- view ----

function draw()
   -- update the object layers in the map based on their entities' models
   for key, ent in pairs(entities) do
      for _, sprite in pairs(layers[key].sprites) do
         sprite.x = ent.x
         sprite.y = ent.y
      end
   end

   print(camX, camY)
   map:setDrawRange(camX, camY, windowWidth, windowHeight)
   map:draw()

   -- draw the entities
   -- FIXME we need to tell entities where to be drawn, because we know the viewport
   -- for k, e in pairs(entities) do
   --    e.draw()
   -- end
   -- No, what we should do is add an object layer to the map for every entity we have, then update the object's
   -- coordinates here before just drawing the map
  
    
end

function act()
end

---- controller ----
-- I guess we dont really have a controller. We are bound to our target entity.

function keypressed(key, isrepeat)
   -- TODO handle nil
   target.keypressed(key, isrepeat)
end

function keyreleased(key)
   -- TODO handle nil
   target.keyreleased(key)
end

function addEntity(entity)
   entity.load()
   entities[entKey] = entity
   map:addCustomLayer("Player", 99)
   local newLayer = map.layers["Player"]
   newLayer.sprites = {
      player = {
         image = entity.image,
         x = entity.x,
         y = entity.y,
         r = 0
      }
   }
   function newLayer:draw()
      for _, sprite in pairs(self.sprites) do
         love.graphics.draw(sprite.image, x, y, r)
      end
   end

   layers[entKey] = newLayer
   
   -- incr shared key
   entKey = entKey + 1
end

--- Add a new entity and set it as the target. The target recieves keypress callbacks.
-- @param entity The entity to add
-- @return nil
function addTarget(entity)
   addEntity(entity)
   target = entity
end
