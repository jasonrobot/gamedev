---- map.lua
--- Handles image display stuff for the  world map / level whatever.
--- called from love.draw()

local G = love.graphics
local HC = require 'HC'

local map = {}
map.__index = map

local tileScale = 2400
local world = HC.new()

local center = world.circle(0, 0, G.getWidth())

local Tile = {}
function Tile.new(imagePath, x, y)
   local t =  {}
   t.image = G.newImage(imagePath)
   t.shape = world.rectangle(x, y, tileScale, tileScale)
   return t
end


local tiles = {}

function map.init()
   tiles.push(Tile.new('assets/blue.png', 0, 0))

end

function map.getTiles(x, y)
   center.moveTo(x, y)
   local collidedShapes = {}
   for shape, delta in pairs(world:collisions(center)) do
      collidedShapes.push(shape)
   end
   for image, shape in next, collidedShapes do
      

end


