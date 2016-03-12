--- Controller.lua
-- This holds common code used by controllers to interact with objects
-- these functions should be common to all entities. If you need anything beyond these basics, override these functions.
--
-- @classmod Controller
-- @usage set your controller module's metatable to this to inherit base controller functionality

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

return Controller
