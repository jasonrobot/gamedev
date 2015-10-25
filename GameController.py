from cocos.layer import Layer
from pyglet.window import key
from common import Direction


class GameController (Layer):
    is_event_handler = True
    def __init__(self, model):
        super().__init__()
        self.model = model
        self.direction = 0
        self.schedule(self.update)

    def on_key_press(self, k, m):
        if k in (key.LEFT, key.RIGHT, key.DOWN, key.UP):
            if k == key.LEFT:
                self.direction = self.direction | Direction.LEFT
            if k == key.RIGHT:
                self.direction = self.direction | Direction.RIGHT
            if k == key.UP:
                self.direction = self.direction | Direction.UP
            if k == key.DOWN:
                self.direction = self.direction | Direction.DOWN
            self.model.move(self.clean_direction())
            return True
        return False

    def on_key_release(self, k, m):
        if k in (key.LEFT, key.RIGHT, key.DOWN, key.UP):
            if k == key.LEFT:
                self.direction = self.direction & ~Direction.LEFT
            if k == key.RIGHT:
                self.direction = self.direction & ~Direction.RIGHT
            if k == key.UP:
                self.direction = self.direction & ~Direction.UP
            if k == key.DOWN:
                self.direction = self.direction & ~Direction.DOWN
            self.model.move(self.clean_direction())
            return True
        return False

    def clean_direction(self):
        final_direction = self.direction
        if (Direction.LEFT | Direction.RIGHT) == final_direction & (Direction.LEFT | Direction.RIGHT):
            final_direction = final_direction & (Direction.UP | Direction.DOWN)
        if (Direction.LEFT | Direction.RIGHT) == final_direction & (Direction.UP | Direction.DOWN):
            final_direction = final_direction & (Direction.LEFT | Direction.RIGHT)
        return final_direction

    def update(self, dt):
        self.model.update(dt)
