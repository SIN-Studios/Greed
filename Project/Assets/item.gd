extends Node2D

var item: enemy

func _ready() -> void:
	if item:
		$AnimatedSprite2D.sprite_frames = item.item_ground_textre

func _process(_delta: float) -> void:
	#checks if the players inventory is full
	if Global.player.player_inventory.inventory_full():
		$interaction/Label.text = "Inventory full: cannot pickup"
		$interaction.can_interact = false
	else:
		$interaction/Label.text = "Hold E to pickup"
		$interaction.can_interact = true


func interacted_with():
	if Global.player.player_inventory.inventory_full():
		return
	Global.player.player_inventory.pickup_item(item)
	queue_free()
