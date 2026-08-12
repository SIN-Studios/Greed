extends Node2D

var item: enemy

func _ready() -> void:
	if item:
		$AnimatedSprite2D.sprite_frames = item.item_ground_textre

func _process(_delta: float) -> void:
	if Global.player.player_inventory.inventory_full():
		$interaction/Label.text = "Inventory full: cannot pickup"
	else:
		$interaction/Label.text = "Hold E to pickup"


func interacted_with():
	if Global.player.player_inventory.inventory_full():
		return
	Global.player.player_inventory.pickup_item(item)
	get_picked_up()

func get_picked_up():
	queue_free()
