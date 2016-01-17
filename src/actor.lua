---- Actor.lua
--- This object represents either a player, npc, or object that can be involved in the script

local Actor = {}
setmetatable(Actor, {__index = _G})
setfenv(1, Actor)

pos = {
   x = 0,
   y = 0,
   -- might never need this
   z = 0,
}

-- Constructor
local function new (x, y)
   self.pos.x = x
   self.pos.y = y
   return self
end

print(foo)

init = {
   new = new,
}

