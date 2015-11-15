local P = {}
setmetatable(P, {__index = _G})
map = P
setfenv(1, P)

local sti = require "lib.Simple-Tiled-Implementation"

local map = nil
local camX = 100
local camY = 100
local target = nil


local entities = {}

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
   camy = target.y
   for k, e in pairs(entities) do
      e.update(dt)
   end
      
end

---- view ----

function draw()
  map:setDrawRange(camX, camY, windowWidth, windowHeight)
  map:draw()

  -- draw the entities
  -- FIXME we need to tell entities where to be drawn, because we know the viewport
  for k, e in pairs(entities) do
     e.draw()
  end
  
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
   table.insert(entities, entity)
end

--- Add a new entity and set it as the target. The target recieves keypress callbacks.
-- @param entity The entity to add
-- @return nil
function addTarget(entity)
   addEntity(entity)
   target = entity
end
