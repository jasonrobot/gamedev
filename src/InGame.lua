--- InGame.lua
-- This is the main gamestate where all the play takes place
-- This object is a singleton, there is only ever one instance

-- imports &c
local G = love.graphics

local Camera = require 'camera'
-- Signal = require 'signal'
local HC = require 'HC'
local STI = require 'STI'

local Object = require 'Object'
local PlayerController = require 'PlayerController'
local FollowerController = require 'FollowerController'
local ShimController = require 'ShimController'
--local Gamestate = require 'gamestate'

--local table
local state = {}

local Map = require 'Map'
local cam
local map

local entities = {}

--- GameState handlers and overrides ---
function state:init()
   entities.mainObject = PlayerController(Object(0, 0, 36, 36))

--   entities.anotherObject = PlayerController(Object(48, 48, 36, 36))

--   entities.static = ShimController(Object(200, 300, 128, 128))

   entities.follower = FollowerController(Object(0, 1000, 24, 24), entities.mainObject)

   --   Map.init()
   
   map = STI.new('assets/tiled-test.lua')

   for k, v in next, map.objects do
      entities['static_' .. k] = ShimController(Object(v.x, v.y, v.width, v.height))
   end
      
   cam = Camera(0, 0)
   for k, v in next, entities do
      print(k, v.ps or v.object.ps)
   end
   
end

function state:update(dt)
   for k, v in next, entities do
      v:update(dt)
      for other in pairs(HC.neighbors(v.object.ps)) do
	 local collides, dx, dy = v.object.ps:collidesWith(other)
	 if collides then
	    v:fixCollision(dx, dy)
	 end
      end
   end   

   map:update(dt)

   cam:lookAt(entities.mainObject:getCenter())
   
end

function state:draw()
   cam:attach()

   map:draw()

   Signal.emit('draw')

   cam:detach()
end

function state:keypressed(key, code)
   Signal.emit(key)
end

function state:keyreleased(key, code)
   Signal.emit(key .. '_released')
end

return state;
