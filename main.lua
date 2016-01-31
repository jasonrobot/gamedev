-- main.lua
-- entry point for the Love2d game engine
package.path = package.path .. ";lib/?/init.lua;lib/?.lua;lib/hump/?.lua;src/?.lua"
local Camera = require "camera"
local Signal = require "signal"

local Actor = require "actor"

local collisionMessage = {}

function love.load ()
   -- Only ever called once. Load the scene manager here.

   --Load the scene manager here.
   --  Scene manager will load the maps and actors as needed.

   -- actor = Actor.new(200, 200)
   -- anotherActor = Actor.new(666, 666)
   -- actor = Actor(200, 200, "assets/placeholder.png")

   -- anotherActor = Actor(666, 666, "assets/placeholder.png")

   -- cam = Camera(actor.ps:center())
   -- map = love.graphics.newImage("assets/blue.png")

   -- signalRegistry = Signal.new()
   
end

function love.update (dt)
   -- -- Handle input here

   -- -- Call the controll handler to fire input events
   -- --   This will move all the controlled actors
   -- -- Call the AI routine to play a turn for NPC actors
   -- -- Call the camera routine to update the camera location

   -- actor:moveBy(1, 0)
   -- --   print(cam.x, cam.y)
   -- local ax, ay = actor.ps:center()
   -- local dx, dy = ax - cam.x, ay - cam.y

   -- cam:move(dx/2, dy/2)
   
end

function love.draw ()
   -- --begin camera
   -- cam:attach()
   
   -- love.graphics.draw(map, 0, 0)
   -- actor:draw()

   -- cam:detach()
   -- -- end camera
   
end
