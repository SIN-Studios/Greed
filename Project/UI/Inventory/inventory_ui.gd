extends Control

var is_open: bool
@onready var inventory_slots: Array = $inventory/GridContainer.get_children()
@export var player_inventory: inventory


func _ready() -> void:
	close()

func update_slots():
	for i in range(min(player_inventory.items.size(), inventory_slots.size())):
		inventory_slots[i].update(player_inventory.items[i])

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
