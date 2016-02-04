---- PlayerKeymap.lua
--- This is really the controller for an actor class that uses player input
--- Depends on Actor.lua
-- local Signal = require 'hump.signal'

local PlayerController = {}
PlayerController.__index = PlayerController

local function new(newModel)
   return setmetatable({model = newModel}, PlayerController)
end


function PlayerController:up()
   self.model.dy = self.model.dy - self.model.dMax
end

function PlayerController:down()
   self.model.dy = self.model.dy + self.model.dMax
end

function PlayerController:right()
   self.model.dx = self.model.dx + self.model.dMax
end

function PlayerController.left(self)
   self.model.dx = self.model.dx - self.model.dMax
end

function PlayerController:register()
   Signal.register('up', function() self.up(self) end)
   Signal.register('down', function() self.down(self) end)
   Signal.register('right', function() self.right(self) end)
   Signal.register('left', function() self.left(self) end)
   
end

function PlayerController:update(dt)
   self.model:update(dt)
end

return setmetatable({}, {__call = function(_,...) return new(...) end})
