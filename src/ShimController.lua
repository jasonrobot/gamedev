--- ShimController.lua
-- A controller that does nothing!
-- Just here to maintain consisteny of Objects being wrapped in Controllers
-- @classmod ShimController

local Controller = require 'Controller'

local ShimController = setmetatable({}, Controller)
ShimController.__index = ShimController

local function new(newObject)
   return setmetatable({object = newObject}, ShimController)
end

return setmetatable({}, {__call = function(_, ...) return new(...) end})
