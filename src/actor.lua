---- Actor.lua
--- This object represents either a player, npc, or object that can be involved in the script

local P = {}
setmetatable(P, {__index = _G})
setfenv(1, P)


-- Constructor
local function new (x, y)
   t = {}

   t.pos = {
      x = 0,
      y = 0,
      -- might never need this
      z = 0,
   }
   
   t.pos.x = x
   t.pos.y = y
   return t
end

return setmetatable(
   {new = new},
   {__call = function(_, ...)
       return new(...)
   end
   }
)
