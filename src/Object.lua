--- Object.lua
-- This object represents either a player, npc, or object that can be involved
-- in the script
--
--@module Object

local HC = require 'HC'
local Vector = require 'vector'

local Object = {}
-- The deal with this is that we are both the metatable and the lookup resource
-- for the new tables we construct
Object.__index = Object

local velMax = 250
local accMax = 25

--- Constructor
-- @param x center x
-- @param y center y
-- @param w width
-- @param h height
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

--- Returns the center of the object as x, y
-- @return x
-- @return y
function Object:getCenter()
   return self.ps:center()
end

function Object:draw ()
   self.ps:draw('fill')
end

--- doIntentions
-- this function takes requests from wrapping controllers and
-- moved the object code accordingly
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

--- fixCollision
-- this function actually just counteracts the intentions being applied to the
-- object to keep it from going into another object.
-- @param dx the x of the seperating vector from HC
-- @param dy the y of the seperating vector from HC
function Object:fixCollision(dx, dy)
   if self.intentions.up or self.intentions.down or
   self.intentions.left or self.intentions.right then
      if dx ~= 0 then self.vel.x = 0 end
      if dy ~= 0 then self.vel.y = 0 end
      
      self.ps:move(dx, dy)
   end
end

--- update
-- runs the physics movement for the object. applies acceleration to velocity
-- and velocity to displacement. Keeps these values below the maximum allowable
-- for the object
-- @param dt delta time
function Object:update(dt)
   self:doIntentions()
   self.vel = self.vel + self.acc
   --clamp vel
   if self.vel:len() > velMax then
      self.vel = self.vel:normalized() * velMax
   end

   self.ps:move((self.vel * dt):unpack())
end

--return the module
return setmetatable({},{__call = function(_, ...) return new(...) end})
