--- BulletController.lua
-- This is the controller for bullet entities
-- A bullet is a type of projectile; it has a physical size, a range, and a speed
local Vector = require 'vector'

local Controller = require 'Controller'

local BulletController = setmetatable({}, Controller)
BulletController.__index = BulletController

--- Default Mover function for bullets
-- This is a simple and somewhat useless linear movement function
-- but it shows how these should be written
-- @param object the object that represents the projectile
-- @param dt the frame delta time
local function defaultMover(object, dt)
   local direction = math.random() * 2 * math.pi
   object.acc = Vector(50, 0):rotated(direction)
   object:update(dt)
end

--- Entity constructor
-- Makes a new bullet
-- @param object the object representing the physical bullet
-- @param mover the desired motion of the projectile as a function of dt
-- @see defaultMover
local function new(object, mover)
   local t = {}
   t.object = object
   local speed = 1000
   local direction = math.random() * 2 * math.pi
   local objectVel = Vector(speed, 0):rotated(direction)
   t.object.vel = objectVel
   t.mover = mover or defaultMover
   t.object.intentions.inanimate = true
   print(t.object.acc, t.object.vel)
   return setmetatable(t, BulletController)
end

function BulletController:fixCollision(dx, dy)
   return
end

function BulletController:update(dt)
   -- self.object = self.mover(self.object, dt)
   self.mover(self.object, dt)
   self.object:update(dt)
   print(self.object.vel)
end

return setmetatable({}, {__call = function(_, ...) return new(...) end})
