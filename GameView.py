import cocos
from cocos.layer import Layer, ScrollableLayer, ScrollingManager
from cocos.sprite import Sprite
from cocos.actions import MoveTo, Place

class GameView (Layer):
    def __init__(self, model):
        super().__init__()
        self.model = model
        self.model.push_handlers(self.on_model_update)

        # self.sprite = Sprite('megaman.png')
        # #self.sprite.position = model.location['x'], model.location['y']
        # self.sprite.position = 1920//2, 1080//2
        # self.sprite.scale = 1
        # self.add(self.sprite, z=1)

        self.world_map = cocos.tiles.load_tmx('hyrule-world.tmx')

        self.scroll_manager = ScrollingManager()
        self.scroll_manager.add(self.world_map.contents['ground'], 0, 'world_ground')
        self.scroll_manager.add(self.world_map.contents['water'], 1, 'world_water')
        self.scroll_manager.add(self.world_map.contents['walls'], 2, 'world_walls')
        self.scroll_manager.add(self.world_map.contents['objects'], 3, 'world_objects')
        self.scroll_manager.add(self.world_map.contents['doors'], 4, 'world_doors')

        self.scroll_manager.scale = 2
        
        self.add(self.scroll_manager, z=0)

    def on_model_update(self):
        #movement = Place((self.model.location['x'], self.model.location['y']))
        #self.sprite.do(movement)
        self.scroll_manager.set_focus(self.model.location['x'], self.model.location['y'])
