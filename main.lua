-- main.lua
-- entry point for the Love2d game engine
package.path = package.path .. ";lib/?/init.lua;lib/?.lua;lib/hump/?.lua;src/?.lua"
local Camera = require "camera"
local Signal = require "signal"
local Gamestate = require "gamestate"

local Actor = require "actor"

local G = love.graphics

-- gamestates
local mainMenu = require "MainMenu"
local game = {}

function love.load ()
   -- Only ever called once. Load the scene manager here.
   Gamestate.registerEvents()
   Gamestate.switch(mainMenu)
   
end
