extends Panel

@onready var item_display: AnimatedSprite2D = $CenterContainer/Panel/item_display

func update_texture(item) -> void:
	if item != null:
		item_display.sprite_frames = item.item_inventory_texture
		item_display.visible = true
	else:
		item_display.sprite_frames = null
		item_display.visible = false

func update_item(slot_item: enemy) -> void:
	if !slot_item:
		return
	
