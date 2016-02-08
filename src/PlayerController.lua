---- PlayerKeymap.lua
--- This is really the controller for an actor class that uses player input
--- Depends on Object.lua

local PlayerController = {}
PlayerController.__index = PlayerController

local function new(newObject)
   local t = setmetatable({object = newObject}, PlayerController)
   t:registerCallbacks()
   return t
end

function PlayerController:getCenter()
   return self.object:getCenter()
end

function PlayerController:up()
   self.object.dy = self.object.dy - self.object.dMax
end

function PlayerController:down()
   self.object.dy = self.object.dy + self.object.dMax
end

function PlayerController:right()
   self.object.dx = self.object.dx + self.object.dMax
end

function PlayerController.left(self)
   self.object.dx = self.object.dx - self.object.dMax
end

function PlayerController:registerCallbacks()
   Signal.register('up', function() self.up(self) end)
   Signal.register('down', function() self.down(self) end)
   Signal.register('right', function() self.right(self) end)
   Signal.register('left', function() self.left(self) end)

   Signal.register('down_released', function() self.up(self) end)
   Signal.register('up_released', function() self.down(self) end)
   Signal.register('left_released', function() self.right(self) end)
   Signal.register('right_released', function() self.left(self) end)
   
end

function PlayerController:update(dt)
   self.object:update(dt)
end

return setmetatable({}, {__call = function(_,...) return new(...) end})
