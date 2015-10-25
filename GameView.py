from cocos.layer import Layer
from cocos.sprite import Sprite
from cocos.actions import MoveTo, Place

class GameView (Layer):
    def __init__(self, model):
        super().__init__()
        self.model = model
        self.model.push_handlers(self.on_move, self.on_model_update)

        self.sprite = Sprite('megaman.png')
        self.sprite.position = model.location['x'], model.location['y']
        self.sprite.scale = 1
        self.add(self.sprite, z=1)

    def on_move(self):
        #draw the sprite
        if self.sprite.are_actions_running() == False:
            movement = MoveTo((self.model.location['x'], self.model.location['y']), 0.1)
            self.sprite.do(movement)

    def on_model_update(self):
        movement = Place((self.model.location['x'], self.model.location['y']))
        self.sprite.do(movement)
