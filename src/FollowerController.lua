---- FollowerController.lua
--- This controls an Actor object that just follows the player

local FollowerController = {}
FollowerController.__index = FollowerController

local followDistance = 100

local function new(newObject, whoToFollow)
   local t = setmetatable({object = newObject,
			   target = whoToFollow
			  },FollowerController)
   Signal.register('update', function (dt) t:update(dt) end)
   return t
end

function FollowerController:update(dt)
   --if the distance from self.object to target.object < followDistance
   local x, y = self.object:getCenter()
   local tx, ty = self.target:getCenter()
   local distance = math.sqrt(math.abs( (x - tx)^2 + (y - ty)^2 ))
   if distance > followDistance then
      --find the direction to the target
      if math.abs(tx - x) > distance / 2 then
	 if tx > x then
	    self.object.dx = self.object.dx + self.object.dMax
	 else
	    self.object.dx = self.object.dx - self.object.dMax	 
	 end
      end
      if math.abs(ty - y) > distance / 2 then      
	 if ty > y then
	    self.object.dy = self.object.dy + self.object.dMax
	 else
	    self.object.dy = self.object.dy - self.object.dMax
	 end
      end
      --call the movement functions on self.object that move towards target
--      print(self.object.dx, self.object.dy)
   else
      self.object.dx = 0
      self.object.dy = 0
   end
   
   self.object:update(dt)
end

function FollowerController:getCenter()
   return self.object:getCenter()
end

return setmetatable({}, {__call = function (_, ...) return new(...) end})
