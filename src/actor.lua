---- Actor.lua
--- This object represents either a player, npc, or object that can be involved in the script

local Actor = {}
-- The deal with this is that we are both the metatable and the lookup resource for the new tables we construct
Actor.__index = Actor
setmetatable(Actor, {__index = _G})
setfenv(1, Actor)

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
   return setmetatable(t, Actor)

end

function Actor:moveBy (x, y)
   self.pos.x = self.pos.x + x
   self.pos.y = self.pos.y + y

end

return setmetatable(
   {new = new, moveBy = moveBy},
   {__call = function(_, ...)
       return new(...)
   end,
   }
)
