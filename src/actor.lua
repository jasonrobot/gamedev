---- Actor.lua
--- This object represents either a player, npc, or object that can be involved in the script

local Actor = {}
-- The deal with this is that we are both the metatable and the lookup resource for the new tables we construct
Actor.__index = Actor
setmetatable(Actor, {__index = _G})
setfenv(1, Actor)

--- Constructor
-- @param x
-- @param y
-- @param image This is a string path to the image. Do not pass a loaded image!
local function new (x, y, image)
   t = {}

   t.pos = {
      x = 0,
      y = 0,
      -- might never need this
      z = 0,
   }

   t.sprite = love.graphics.newImage(image)
   
   t.pos.x = x
   t.pos.y = y
   return setmetatable(t, Actor)

end

function Actor:moveBy (x, y)
   self.pos.x = self.pos.x + x
   self.pos.y = self.pos.y + y

end

--- Draw this actor at its current coordinates.
-- You should set the sprite before you do this.
function Actor:draw ()
   -- FIXME: this is hacky, make it work per instance
   love.graphics.push()
   
   love.graphics.scale(0.25, 0.25)
   love.graphics.draw(self.sprite, self.pos.x, self.pos.y)
   
   love.graphics.pop()

end

return setmetatable(
   {new = new, moveBy = moveBy},
   {__call = function(_, ...)
       return new(...)
   end,
   }
)
