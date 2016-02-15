---- MainMenu.lua
--- This is the gamestate for the Main Menu
local Gamestate = require 'gamestate'
local G = love.graphics
local InGame = require 'InGame'

local state = {}

local menuOptions = {
   'Start a new game',
   'Load a saved game',
   'Check out the options menu',
   'Return from whence you came',
}

local selectedOptionIndex = 1

function state.draw()
   local strbuf = ''
   for i = 1, #menuOptions, 1 do
      if i == selectedOptionIndex then
	 strbuf = '>>> '
      end
      strbuf = strbuf .. menuOptions[i]
      G.print(strbuf, 20, i * 20)
      strbuf = ''
   end
   
end

function state:keypressed(key, code)
   if key == 'down' then
      selectedOptionIndex = selectedOptionIndex + 1
   end
   if key == 'up' then
     selectedOptionIndex = selectedOptionIndex - 1
   end
   if key == 'return' then
      if selectedOptionIndex == 1 then
	 Gamestate.switch(InGame)
      end
   end
   
end

return state
