import math
from pyglet.event import EventDispatcher
from common import Direction

class GameModel (EventDispatcher):
    def __init__(self):
        super().__init__()
        self.location = {'x': 0, 'y': 0}
        #uses common.Direction as flags
        self.direction = 0
        #pixels per second
        self.speed = 500
        self.register_event_type("on_move")
        self.register_event_type("on_model_update")

    def move(self, direction):
        self.direction = direction
        
    def update(self, dt):
        if self.direction == 0:
            return
        #should dispatch an event to observers when the model is updated
        #use the dt and the speed to calculate how far we should move
        #then use the direction to see where we wne up
        distance = self.speed * dt
        #update our position
        dx = 0
        dy = 0
        if self.direction == Direction.UP:
            dy = distance
        if self.direction == Direction.DOWN:
            dy = -distance
        if self.direction == Direction.RIGHT:
            dx = distance
        if self.direction == Direction.LEFT:
            dx = -distance
        if self.direction == (Direction.UP | Direction.RIGHT):
            dx = distance // math.sqrt(2)
            dy = dx
        if self.direction == (Direction.UP | Direction.LEFT):
            dy = distance // math.sqrt(2)
            dx = -dy
        if self.direction == (Direction.DOWN | Direction.RIGHT):
            dx = distance // math.sqrt(2)
            dy = -dx
        if self.direction == (Direction.DOWN | Direction.LEFT):
            dx = -distance // math.sqrt(2)
            dy = dx
        self.location['x'] += dx
        self.location['y'] += dy
        self.dispatch_event("on_model_update")
