extends Panel

@onready var item_display: AnimatedSprite2D = $CenterContainer/Panel/item_display

func update_texture(slot_item: enemy) -> void:
	print("uh")
	if !slot_item:
		return
	print("uh uh uh")
	item_display.sprite_frames = slot_item.item_inventory_texture

func update_item(slot_item: enemy) -> void:
	if !slot_item:
		return
	
