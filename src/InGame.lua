---- InGame.lua
--- This is the main gamestate where all the play takes place
-- This object is a singleton, there is only ever one instance

-- imports &c
local G = love.graphics

local Camera = require "camera"
-- Signal = require "signal"
HC = require "HC"

local Object = require "Object"
local PlayerController = require "PlayerController"
--local Gamestate = require "gamestate"

--local table
local state = {}

local Map = require "Map"
local cam

local objects = {}

--- GameState handlers and overrides ---
function state:init()
   objects.mainObject = PlayerController(Object(0, 0, 36, 36))

   objects.anotherObject = PlayerController(Object(48, 48, 36, 36))

   objects.static = Object(1200, 1200, 128, 128)

   Map.init()
   cam = Camera(0, 0)
end

function state:update(dt)
   Signal.emit('update', dt)
   cam:lookAt(objects.mainObject:getCenter())
   
end

function state:draw()
   cam:attach()

--   G.draw(mapImage, -1500, -1500)
   Map.drawTiles(cam:position())
   Signal.emit("draw")

   cam:detach()
end

function state:keypressed(key, code)
   Signal.emit(key)
end

function state:keyreleased(key, code)
   Signal.emit(key .. '_released')
end

return state;
