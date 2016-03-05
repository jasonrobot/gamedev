--- TargetLocator.lua
-- This handles target detection for entities
-- it provides two functions, :nextTarget() and :previousTarget() that each
-- return an object to target
-- probably eventually you can pass it a targeting strategy function
local HC = require 'HC'
local vector_light = require 'hump.vector-light'

local TargetLocator = {}
TargetLocator.__index = TargetLocator

-- Chooses a target from multiple options
-- @param x
-- @param y
-- @param targets An array of objects
local defaultDetectionStrategy = function (x, y, targets)
   local best
   for k, v in next, targets do
      if best == nil then best = k
      else if vector_light.dist(x, y, k:center()) < vector_light.dist(x, y, best:center())
	 and vector_light.dist(x, y, k:center()) > 3 then
	    best = k
	   end
      end
   end
   return best
end

local function new(targetDetector, detectionStrategy)
   local t = {}
   t.detector = targetDetector
   if detectionStrategy == nil then
      t.strategy = defaultDetectionStrategy
   else
      t.strategy = detectionStrategy
   end
   
   t = setmetatable(t, TargetLocator)
   return t
end

function TargetLocator:seekTargets()
   return HC.collisions(self.detector)
end

function TargetLocator:nextTarget()
   local x, y = self.detector:center()
   self.currentTarget = self.strategy(x, y, self.seekTargets(self))
   print(self.currentTarget)
end

-- affirms that a target can be targeted
-- @param entity the target entity
function TargetLocator:isTargetValid(target)
   if target == nil then return true end
   -- target is not us
   if vector_light.dist(self.detector:center(), target:center()) < 3 then
      return false
   end
   -- is still on screen
   if not target:collidesWith(self.detector) then
      print('did not collide')
      return false
   end
   return true
end

function TargetLocator:updatePosition(x, y)
   self.detector:moveTo(x, y)
   print(self.detector, self.currentTarget)
   
   if self.currentTarget ~= nil and not self.detector:collidesWith(self.currentTarget) then
      print('invalid')
      self.nextTarget(self)
   end
end

return setmetatable({}, {__call = function(_, ...) return new(...) end})
