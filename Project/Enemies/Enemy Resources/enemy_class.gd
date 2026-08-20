extends Resource

#class for enemy which is referenced when creating enemy files, includes what they drop
class_name enemy

@export var name: String
@export var item_inventory_texture: SpriteFrames
@export var item_ground_textre: SpriteFrames
@export var texture: SpriteFrames
@export var health: int
@export var base_damage: int
@export var nutrition: int
