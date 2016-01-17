-- main.lua
-- entry point for the Love2d game engine
local Camera = require "lib.hump.camera"
local window = {}

player = {}
player.pos = {}
player.pos.x = 200
player.pos.y = 200

function love.load()
   cam = Camera(player.pos.x, player.pos.y)
   map = love.graphics.newImage("assets/blue.png")
   
end

function love.update(dt)
   player.pos.x = player.pos.x + 1
--   print(cam.x, cam.y)
   local dx, dy = player.pos.x - cam.x, player.pos.y - cam.y
   print(dx, dy)
   cam:move(dx/2, dy/2)
   
end

function love.draw()
   --begin camera
   cam:attach()
   
   love.graphics.draw(map, 0, 0)

   cam:detach()
   -- end camera
   
end
