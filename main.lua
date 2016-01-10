-- main.lua
-- entry point for the Love2d game engine
local sti = require "sti"

function love.load()
   love.window.setMode(640, 640)   

   map = sti.new("tiled-02.lua")

   -- create a new dynamic layer for sprites as layer 5
   local layer = map:addCustomLayer("Sprites", 3)

   -- he says: get the player spawn object
   --  I'm guessing that the object in the map is just what we're using as a refrence to
   --  place our fully dynamic entity on
   local playerObject
   for i, object in ipairs(map.objects) do
      if object.name == "player" then
	 playerObject = object
	 break
      end
   end

   --create the player object
   local sprite = love.graphics.newImage("megaman.png")
   layer.player = {
      sprite = sprite,
      x = playerObject.x,
      y = playerObject.y,
      ox = sprite:getWidth() / 2,
      oy = sprite:getHeight() / 1.35,
   }

   --   layer.draw = function(self)
   function layer:draw()
      love.graphics.draw(
	 self.player.sprite,
	 math.floor(self.player.x),
	 math.floor(self.player.y),
	 0,
	 1,
	 1,
	 self.player.ox,
	 self.player.oy
      )

      --draw a point at the location, just to use as a refrence or something
      --to make sure our draw method isnt fucked
      love.graphics.setPointSize(5)
      love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
   end

   map:removeLayer("player")
end

function love.update(dt)
   map:update(dt)
   
end

function love.draw()
   map:draw()
   
end
