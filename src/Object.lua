---- Object.lua
--- This object represents either a player, npc, or object that can be involved in the script

local HC = require 'HC'
local Vector = require 'vector'
local G = love.graphics

local Object = {}
-- The deal with this is that we are both the metatable and the lookup resource for the new tables we construct
Object.__index = Object

local velMax = 250
local accMax = 25

--- Constructor
-- @param x
-- @param y
-- @param image This is a string path to the image. Do not pass a loaded image!
local function new (x, y, w, h)
   local t = {ps = HC.rectangle(x, y, w, h),
	      vel = Vector(0, 0),
	      acc = Vector(0, 0),
	      intentions = {},
	      velMax = velMax,
	      accMax = accMax,}
   t = setmetatable(t, Object)
   --HC.register(t.ps)
   Signal.register('draw', function () t:draw() end)
   return t
end

function Object:getCenter()
   return self.ps:center()
end

function Object:draw ()
   self.ps:draw('fill')
end

function Object:doIntentions()
   if self.intentions.up or self.intentions.down then
      if self.intentions.up then
	 --move up
	 self.acc.y = -self.accMax
      end
      if self.intentions.down then
	 --move down
	 self.acc.y = self.accMax
      end
   else
      --stop moving up or down
      if math.abs(self.vel.y) < 25 then
	 self.vel.y = 0
	 self.acc.y = 0
      elseif self.vel.y > 0 then
	 self.acc.y = -accMax
      else
	 self.acc.y = accMax
      end

   end
   if self.intentions.left or self.intentions.right then
      if self.intentions.left then
	 --move left
	 self.acc.x = -self.accMax
      end
      if self.intentions.right then
	 --move right
	 self.acc.x = self.accMax
      end
   else
      --stop moving up or down
      if math.abs(self.vel.x) < 25 then
	 self.vel.x = 0
	 self.acc.x = 0
      elseif self.vel.x > 0 then
	 self.acc.x = -accMax
      else
	 self.acc.x = accMax
      end
   end   
end

function Object:fixCollision(dx, dy)
   if self.intentions.up or self.intentions.down or
   self.intentions.left or self.intentions.right then
      if dx ~= 0 then self.vel.x = 0 end
      if dy ~= 0 then self.vel.y = 0 end
      
      self.ps:move(dx, dy)
      
   end
end

function Object:update(dt)
   self:doIntentions()
   self.vel = self.vel + self.acc
   --clamp vel
   if self.vel:len() > velMax then
      self.vel = self.vel:normalized() * velMax
   end

   self.ps:move((self.vel * dt):unpack())
end

-- this in effect returns a class that can be called to create actors
return setmetatable({},{__call = function(_, ...) return new(...) end})
