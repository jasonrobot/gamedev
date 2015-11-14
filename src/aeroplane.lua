local P = {}
setmetatable(P, {__index = _G})
aeroplane = P
setfenv(1, P)

--- model object represents the current state of the entity
local model = {
   x = 200,
   y = 100,
   maxd = 200,
   dx = 0,
   dy = 0,
   maxdd = 500,
   ddx = 0,
   ddy = 0,
   speed = 150,
}

imageSource = "assets/megaman.png"
image = nil

--- control object represents inputs from the controller to be passed to the model
-- in a very direct way, this object defines the capabilities of how this entity can be controlled
-- any idea of control not mapped here can not be processed by the entity model
local control = {
--TODO need a way to set capabilities of entities
   --what direction we are being asked to move
   directionIntent = 0,
   
   --- bit flags indicating direction
   direction = {
      left = 0x1,
      down = 0x2,
      right = 0x4,
      up = 0x8,
   }
      
}

--- load all the entity's resources
function load()
   image = love.graphics.newImage(imageSource)
end

--- updates the model based on inputs processed from the controller that are stores in the control object
function update(dt)
   
end

--- updates the controller table based on commands from an intelligence source
function keypressed(key, isrepeat)
   print("Key pressed: ")
   print(key)
end

--- make pretty in graphics buffer (model willing)
function draw()
   love.graphics.draw(image, model.x, model.y)
end


