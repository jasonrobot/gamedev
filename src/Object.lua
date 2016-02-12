---- Object.lua
--- This object represents either a player, npc, or object that can be involved in the script

local HC = require "HC"
-- local G = love.graphics
local abs = math.abs

local Object = {}
-- The deal with this is that we are both the metatable and the lookup resource for the new tables we construct
Object.__index = Object

local dMax = 250

--- Constructor
-- @param x
-- @param y
-- @param image This is a string path to the image. Do not pass a loaded image!
local function new (x, y, w, h)
   local t = setmetatable({ps = HC.rectangle(x, y, w, h),
			   dx = 0,
			   dy = 0,
			   dMax = dMax}, Object)
   HC.register(t.ps)
   Signal.register("draw", function () t:draw() end)
   return t
end

function Object:getCenter()
   return self.ps:center()
end

function Object:draw ()
   self.ps:draw("fill")

end

function Object:update(dt)
   if abs(self.dx) > dMax then
      if self.dx > 0 then self.dx = dMax end
      if self.dx < 0 then self.dx = -dMax end
   end
   if abs(self.dy) >= dMax then
      if self.dy > 0 then self.dy = dMax end
      if self.dy < 0 then self.dy = -dMax end
   end

   self.ps:move(self.dx * dt, self.dy * dt)
end

-- this in effect returns a class that can be called to create actors
return setmetatable({},{__call = function(_, ...) return new(...) end})
