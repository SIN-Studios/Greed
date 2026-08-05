extends Node2D

var item: enemy

func _ready() -> void:
	SignalManager.player_has_room.connect(get_picked_up)
	if item:
		$AnimatedSprite2D.sprite_frames = item.item_ground_textre


func interacted_with():
	SignalManager.player_picks_up_item.emit(item, self)
	
func get_picked_up(body):
	if body == self:
		queue_free()
