#!/usr/bin/env python
from cocos.director import director
from GameModel import GameModel
from GameView import GameView
from GameController import GameController
from cocos.scene import Scene

'''
This is the main class to the game. It starts the director listening for events, then starts the main menu scene
'''

def get_new_game():
    scene = Scene()
    scene.enable_handlers(True)
    model = GameModel()
    view = GameView(model)
    controller = GameController(model)
    scene.add(controller, z=1, name="controller")
    scene.add(view, name="view")
    return scene

director.init(width=1920, height=1080, caption="hello World", fullscreen=True)
director.run(get_new_game())

