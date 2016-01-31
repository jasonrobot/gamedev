---- Actor.lua
--- This object represents either a player, npc, or object that can be involved in the script

HC = require "HC"
local G = love.graphics
local Actor = {}
-- The deal with this is that we are both the metatable and the lookup resource for the new tables we construct
Actor.__index = Actor
--setfenv(1, Actor)





--- Constructor
-- @param x
-- @param y
-- @param image This is a string path to the image. Do not pass a loaded image!
local function new (x, y, image)
   local sprite = love.graphics.newImage(image)
   w, h = sprite:getDimensions()

   local physicalSelf = HC.rectangle(x, y, w, h)

   return setmetatable({spr = sprite, ps = physicalSelf}, Actor)
end

return setmetatable({new = new},{__call = function(_, ...) return new(...) end})
