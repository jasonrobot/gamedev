---- InGame.lua
--- This is the main gamestate where all the play takes place
-- This object is a singleton, there is only ever one instance

-- imports &c
local G = love.graphics

local Camera = require "camera"
local Signal = require "signal"
--local Gamestate = require "gamestate"

--local table
local state = {}
state.sig = Signal.new()

local actor

local map
local cam

--- GameState handlers and overrides ---
function state:init()
   actor = new Actor("assets/placeholder.png", 0, 0)

   map = G.newImage("assets/blue.png")   
   cam = Camera(0, 0)
end

function state:update(dt)
   cam:lookAt(actor:ps.center()
end

function state:draw(dt)
   cam:attach()

   G.draw(map, 0, 0)
   
   cam:detach()
end

function state:keypressed(key, code)
   self.sig.emit(key)
end

return state;
