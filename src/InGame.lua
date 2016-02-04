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

local map
local cam

--- GameState handlers and overrides ---
function state:init()
   local actor = Actor(0, 0, 100, 100)
   print(actor)
   player = PlayerController(actor)
   player:register()
   print(player.model)
   player:update(1)
   HC.register(player.model.ps)
   Signal.register("draw", function () actor:draw() end)

   map = G.newImage("assets/blue.png")   
   cam = Camera(0, 0)
end

function state:update(dt)
   player:update(dt)
   cam:lookAt(player.model.ps:center())
   
end

function state:draw()
   cam:attach()

   G.draw(map, 0, 0)
   Signal.emit("draw")
   
   cam:detach()
end

function state:keypressed(key, code)
   Signal.emit(key)
end

return state;
