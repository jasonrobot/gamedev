-- main.lua
-- entry point for the Love2d game engine
local Camera = require "lib.hump.camera"
local Signal = require "lib.hump.signal"

HC = require "lib.HC"

local Actor = require "src.actor"

local collisionMessage = {}

function love.load ()
   -- actor = Actor.new(200, 200)
   -- anotherActor = Actor.new(666, 666)
   actor = Actor(200, 200, "assets/placeholder.png")

   anotherActor = Actor(666, 666, "assets/placeholder.png")

   cam = Camera(actor.pos.x, actor.pos.y)
   map = love.graphics.newImage("assets/blue.png")

   signalRegistry = Signal.new()
   
end

function love.update (dt)
   -- Handle input here

   actor:moveBy(1, 0)
--   print(cam.x, cam.y)
   local dx, dy = actor.pos.x - cam.x, actor.pos.y - cam.y

   cam:move(dx/2, dy/2)
   
end

function love.draw ()
   --begin camera
   cam:attach()
   
   love.graphics.draw(map, 0, 0)
   actor:draw()

   cam:detach()
   -- end camera
   
end
