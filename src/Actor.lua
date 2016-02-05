}---- Actor.lua
--- This object represents either a player, npc, or object that can be involved in the script

local HC = require "HC"
--local G = love.graphics
local Actor = {}
-- The deal with this is that we are both the metatable and the lookup resource for the new tables we construct
Actor.__index = Actor

function Actor:draw ()
   self.ps:draw("fill")

end

function Actor:update(dt)
   self.ps:move(self.dx * dt, self.dy * dt)
end

--- Constructor
-- @param x
-- @param y
-- @param image This is a string path to the image. Do not pass a loaded image!
local function new (x, y, w, h)
--   local sprite = G.newImage(image)
--   local w, h = sprite:getDimensions()
   
   local physicalSelf = HC.rectangle(x, y, w, h)

   local t = {
      ps = physicalSelf,
      dx = 0,
      dy = 0,
      dMax = 250
   }
   return setmetatable(t, Actor)
end

-- this in effect returns a class that can be called to create actors
return setmetatable({},{__call = function(_, ...) return new(...) end})
