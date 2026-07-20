extends Control

var is_open: bool

@onready var player_inventory: inventory = preload("res://UI/Inventory/players_inventory.tres")
@onready var slots: Array = $inventory/GridContainer.get_children()

func _ready() -> void:
	update_slots()
	close()

func update_slots():
	for i in range(min(player_inventory.items.size(), slots.size())):
		slots[i].update_texture(player_inventory.items[i])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			close()
		else:
			open()

func close():
	visible = false
	is_open = false

func open():
	visible = true
	is_open = true
