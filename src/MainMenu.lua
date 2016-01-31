---- MainMenu.lua
--- This is the gamestate for the Main Menu
local MainMenu = {}

local Gamestate = "gamestate"

local G = love.graphics

local menuOptions = {
   "Start a new game",
   "Load a saved game",
   "Check out the options menu",
   "Return from whence you came",
}

local selectedOptionIndex = 1

function MainMenu.draw()
   local strbuf = ''
   for i = 1, #menuOptions, 1 do
      if i == selectedOptionIndex then
	 strbuf = ">>> "
      end
      strbuf = strbuf .. menuOptions[i]
      G.print(strbuf, 20, i * 20)
      strbuf = ''
   end
   
end

function MainMenu:keypressed(key, code)
   if key == 'down' then
      selectedOptionIndex = selectedOptionIndex + 1
   end
   if key == 'up' then
     selectedOptionIndex = selectedOptionIndex - 1
   end
   
end

return MainMenu
