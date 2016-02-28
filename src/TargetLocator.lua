--- TargetLocator.lua
-- This handles target detection for entities
local HC = require 'HC'

local TargetLocator = {}
TargetLocator.__index = TargetLocator

local function new(targetDetectorShape)
   local t = {}
   t.detectorShape = targetDetectorShape

   t = setmetatable(t, TargetLocator)
   return t
end

function TargetLocator:startTargeting()
   local targets = self.seekTargets(self)
   self.currentTarget = next(targets)
end

function TargetLocator:stopTargeting()
end

-- A wrapper to alterTarget that does logic to make this a nice game usable operation
function TargetLocator:changeTarget()
end

-- affirms that a target can be targeted
-- @param entity the target entity
function TargetLocator:validateCurrentTarget()
   -- target is not us
   if vector_light.dist(self.detectorShape:center(), tx, ty) < 3 then
      return false
   end
   -- is still on screen
   if not self.currentTarget:collidesWith(detectorShape) then
      return false
   end
   return true
end

-- finds new valid targets
-- @return an array of objects for targeting
function TargetLocator:seekTargets()
   local targets = HC.collisions(self.detectorShape)
   for k, v in next, targets do
      print(k)
   end
   return targets
end

function TargetLocator:updatePosition(x, y)
   self.detectorShape:moveTo(x, y)
end

return setmetatable({}, {__call = function(_, ...) return new(...) end})
