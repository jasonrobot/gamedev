---- map.lua
--- Handles image display stuff for the  world map / level whatever.
--- called from love.draw()

local P = {}
setmetatable(P, {__index, _G})
setfenv(1, P)

--- Constructor.
local function new ()
   t = {}

   return t

end

return setmetatable(
   {new = new},
   {__call = function(_, ...)
       return new(...)
   end
   }
)
