---- InGame.lua
--- This is the main gamestate where all the play takes place
-- This object is a singleton, there is only ever one instance

-- imports &c
local G = love.graphics

local Camera = require "camera"
-- Signal = require "signal"
local HC = require "HC"

local Object = require "Object"
local PlayerController = require "PlayerController"
--local Gamestate = require "gamestate"

--local table
local state = {}

local Map = require "Map"
local cam

local actors = {}

--- GameState handlers and overrides ---
function state:init()
   -- table.insert(actors, 'mainObject', Object(0, 0, 36, 36))
   local actor = Object(0, 0, 36, 36)
   local actorName = 'mainObject'
   actors[actorName] = actor
   local player = PlayerController(actor)
   player:registerCallbacks()
   HC.register(actor.ps)
   Signal.register("draw", function () actor:draw() end)
   Signal.register("update", function (dt) player:update(dt) end)

   local actor = Object(48, 48, 36, 36)
   local player = PlayerController(actor)
   player:registerCallbacks()
   HC.register(actor.ps)
   Signal.register("draw", function () actor:draw() end)
   Signal.register("update", function (dt) player:update(dt) end)   

   local actor = Object(1200, 1200, 36, 36)
   HC.register(actor.ps)
   Signal.register("draw", function () actor:draw() end)
   Signal.register("update", function (dt) actor:update(dt) end)   

   --"isometric" map image
--   mapImage = G.newImage("assets/blue-iso.png")
   Map.init()
   cam = Camera(0, 0)
end

function state:update(dt)
   Signal.emit("update", dt)
   cam:lookAt(actors.mainObject.ps:center())
   
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
