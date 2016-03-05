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
      if best == nil then best = v
      else if vector_light.dist(x, y, v:center()) < vector_light.dist(x, y, best:center()) then
	    best = v
	   end
      end
   end
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
   self.currentTarget = self.strategy(self.detector:center(), self.seekTargets(self))  
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
      return false
   end
   return true
end

function TargetLocator:updatePosition(x, y)
   self.detector:moveTo(x, y)
end

return setmetatable({}, {__call = function(_, ...) return new(...) end})
