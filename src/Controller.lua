---- Controller.lua
--- This holds common code used by controllers to interact with objects

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
