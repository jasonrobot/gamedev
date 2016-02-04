---- director.lua
--- This is the game director. It is responsible for dynamically running the game once love is started.

local Director = {}

local sceneTable = {
   BLUE = {
      actors = {
	 actor = Actor(200, 200, "assets/placeholder.png"),
	 anotherActor = Actor(666, 666, "assets/placeholder.png")
      },
      map = {
	 dimensions = {x = 1, y = 1},
	 tiles = {
	    "assets/blue.png"
	 }
      }
   }
}

function Director:loadScene (sceneIndex)
   scene = sceneTable[sceneIndex]
   self.actors = scene.actors

   cam = Camera(scene.actors.actor.ps:center())
   map = love.graphics.newImage(scene.map.tiles[1])

   signalRegistry = Signal.new()

end

return Director
