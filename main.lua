-- main.lua
-- entry point for the Love2d game engine
local Camera = require "lib.hump.camera"
local window = {}
local Actor = require "src.actor"

function love.load ()
   -- actor = Actor.new(200, 200)
   -- anotherActor = Actor.new(666, 666)
   actor = Actor(200, 200)
   print(actor)
   anotherActor = Actor(666, 666)

   cam = Camera(actor.pos.x, actor.pos.y)
   map = love.graphics.newImage("assets/blue.png")

end

function love.update (dt)
   actor.pos.x = actor.pos.x + 1
--   print(cam.x, cam.y)
   local dx, dy = actor.pos.x - cam.x, actor.pos.y - cam.y

   cam:move(dx/2, dy/2)
   
end

function love.draw ()
   --begin camera
   cam:attach()
   
   love.graphics.draw(map, 0, 0)

   cam:detach()
   -- end camera
   
end
