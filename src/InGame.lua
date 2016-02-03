---- InGame.lua
--- This is the main gamestate where all the play takes place
-- This object is a singleton, there is only ever one instance

-- imports &c
local G = love.graphics

local Camera = require "camera"
local Signal = require "signal"
local HC = require "HC"

local Actor = require "Actor"
--local Gamestate = require "gamestate"

local physics = HC.new(200)

--local table
local state = {}
local sig = Signal.new()

local actor

local map
local cam

--- GameState handlers and overrides ---
function state:init()
   actor = Actor( 0, 0)
--   physics.register(actor.ps)
   sig.register("draw", function () actor:draw() end)

   map = G.newImage("assets/blue.png")   
   cam = Camera(0, 0)
end

function state:update(dt)
   cam:lookAt(actor.ps:center())
   
end

function state:draw()
   cam:attach()

   G.draw(map, 0, 0)
   sig.emit("draw")
   
   cam:detach()
end

function state:keypressed(key, code)
   sig.emit(key)
end

return state;
