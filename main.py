#!/usr/bin/env python
from cocos.director import director
from GameModel import GameModel
from GameView import GameView
from GameController import GameController
from cocos.scene import Scene

'''
This is the main game code. It starts the first scene.
'''

def get_new_game():
    scene = Scene()
    model = GameModel()
    view = GameView(model)
    controller = GameController(model)
    scene.add(controller, z=1, name="controller")
    scene.add(view, name="view")
    scene.enable_handlers(True)    
    return scene

director.init(width=1920, height=1080, caption="hello World", fullscreen=True)
director.run(get_new_game())

