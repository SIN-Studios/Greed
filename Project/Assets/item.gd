extends Node2D

var item: enemy

func _ready() -> void:
	if item:
		$AnimatedSprite2D.sprite_frames = item.item_ground_textre


func interacted_with():
	SignalManager.player_picks_up_item.emit(item)
	queue_free()
