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
end

function TargetLocator:stopTargeting()
end

-- A wrapper to alterTarget that does logic to make this a nice game usable operation
function TargetLocator:changeTarget()
end

-- affirms that a target can be targeted
-- @param entity the target entity
function TargetLocator:validateEntity(entity)
   --
end

-- finds new valid targets
-- @return an array of objects for targeting
function TargetLocator:seekTargets()
   for k, v in next, HC.collisions(self.detectorShape) do
      print(k, v.x, v.y)
   end
   
end

function TargetLocator:updatePosition(x, y)
   self.detectorShape:moveTo(x, y)
end

return setmetatable({}, {__call = function(_, ...) return new(...) end})
