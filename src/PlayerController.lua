---- PlayerController.lua
--- This is really the controller for an actor class that uses player input
--- Depends on Object.lua
-- global Signal = require 'hump.signal'
local HC = require 'HC'

local Controller = require 'Controller'
local TargetLocator = require 'TargetLocator'

local PlayerController = setmetatable({}, Controller)
PlayerController.__index = PlayerController

local function new(newObject)
   local t = {}
   t.object = newObject
   local x, y = newObject:getCenter()
   local w, h = love.window.getMode()
   local targetDetectorShape = HC.rectangle(x-(w/2), y-(h/2), w, h)
   targetDetectorShape.fakeObject = true
   t.targetLocator = TargetLocator(targetDetectorShape)


   t = setmetatable(t, PlayerController)
   -- do we really want to do this this way?
   t:registerCallbacks()   
   return t
end

function PlayerController:update(dt)
   self.object:update(dt)
   self.targetLocator:updatePosition(self.object:getCenter())
end

function PlayerController:registerCallbacks()
   -- self.object.intentions.up = false
   -- self.object.intentions.down = false
   -- self.object.intentions.left = false
   -- self.object.intentions.right = false

   Signal.register('up', function() self.object.intentions.up = true end)
   Signal.register('down', function() self.object.intentions.down = true end)
   Signal.register('left', function() self.object.intentions.left = true end)
   Signal.register('right', function() self.object.intentions.right = true end)

   Signal.register('up_released', function() self.object.intentions.up = false end)
   Signal.register('down_released', function() self.object.intentions.down = false end)
   Signal.register('left_released', function() self.object.intentions.left = false end)
   Signal.register('right_released', function() self.object.intentions.right = false end)

   Signal.register('space', function() self.targetLocator:seekTargets() end)
end

return setmetatable({}, {__call = function(_,...) return new(...) end})
