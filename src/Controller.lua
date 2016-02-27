---- Controller.lua
--- This holds common code used by controllers to interact with objects
--global HC = require 'HC'

local Controller = {}
Controller.__index = Controller

function Controller:getCenter()
   return self.object:getCenter()
end

function Controller:update(dt)
   self.object:update(dt)
end

function Controller:fixCollision(dx, dy)
   self.object:fixCollision(dx, dy)
end

function Controller:startTargeting()
   local targets = self.seekTargets(self)
end

function Controller:stopTargeting()
end

-- A wrapper to alterTarget that does logic to make this a nice game usable operation
function Controller:changeTarget()
end

-- affirms that a target can be targeted
-- @param entity the target entity
local validateTarget = function(self, entity)
   --
end

-- finds new valid targets
-- @return an array of objects for targeting
function Controller:seekTargets()
   --create a shape over the window
   local x, y = self.object.getCenter()
   
   x = x - w/2
   y = y - h/2
   -- FIXME each object or entity should just have one of these shapes on hand at all times
   local shape = HC.rectangle(x, y, w, h)
   --get all colliding shapes
   HC.getCollisions(shape)
end

return Controller
