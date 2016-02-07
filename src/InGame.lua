---- InGame.lua
--- This is the main gamestate where all the play takes place
-- This object is a singleton, there is only ever one instance

-- imports &c
local G = love.graphics

local Camera = require "camera"
-- Signal = require "signal"
local HC = require "HC"

local Actor = require "Actor"
local PlayerController = require "PlayerKeymap"
--local Gamestate = require "gamestate"

--local table
local state = {}

local player

local map = require "map"
local cam

--- GameState handlers and overrides ---
function state:init()
   local actor = Actor(0, 0, 36, 36)
   print("first: ", actor, actor.ps)
   player = PlayerController(actor)
   player:registerCallbacks()
   HC.register(actor.ps)
   Signal.register("draw", function () actor:draw() end)

   local actor = Actor(1200, 1200, 36, 36)
   print("second", actor, actor.ps)
   HC.register(actor.ps)
   Signal.register("draw", function () actor:draw() end)

   mapImage = G.newImage("assets/blue.png")
   map.init()
   cam = Camera(0, 0)
end

function state:update(dt)
   player:update(dt)
   cam:lookAt(player.model.ps:center())
   
end

function state:draw()
   cam:attach()

   map.drawTiles(player.model.ps:center())
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
