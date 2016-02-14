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
      if math.abs(tx - x) > 5 then
	 if tx > x then
	    self.object.intentions.right = true
	    self.object.intentions.left = false
	 else
	    self.object.intentions.left = true
	    self.object.intentions.right = false
	 end
      else
	 self.object.intentions.left = false
	 self.object.intentions.right = false
      end
      if math.abs(ty - y) > 5 then
	 if ty > y then
	    self.object.intentions.down = true
	    self.object.intentions.up = false	    
	 else
	    self.object.intentions.up = true
	    self.object.intentions.down = false
	 end
      else
	 self.object.intentions.up = false
	 self.object.intentions.down = false
      end
   else
      self.object.intentions.up = false
      self.object.intentions.down = false
      self.object.intentions.left = false
      self.object.intentions.right = false
   end
   
   self.object:update(dt)
end

function FollowerController:getCenter()
   return self.object:getCenter()
end

return setmetatable({}, {__call = function (_, ...) return new(...) end})
