local P = {}
setmetatable(P, {__index = _G})
map = P
setfenv(1, P)

local sti = require "lib.Simple-Tiled-Implementation"

local map = nil
local camX = 100
local camY = 100
local target = nil


---- model ----

function load()
   windowWidth  = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   map = sti.new("assets/hyrule-world.lua")
end

--- update our camera location based on the target's x and y
function update(dt)
   camX = target.x
   camy = target.y
end

---- view ----

function draw()
--   map:setDrawRange(camX, camY, windowWidth, windowHeight)
--   map:draw()
end

function act()
end

---- controller ----
-- I guess we dont really have a controller. We are bound to our target entity.

function keypressed(key, isrepeat)
end

function keyreleased(key)
end

function setTarget(entity)
   target = entity
end
