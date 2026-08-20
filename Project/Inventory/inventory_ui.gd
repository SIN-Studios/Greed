extends Control

var is_open: bool
@onready var inventory_slots: Array = $inventory/GridContainer.get_children()
@export var player_inventory: inventory = preload("res://Inventory/players_inventory.tres")
var current_item: enemy
var updated_calories: int
var item_calories: int

func _ready() -> void:
	SignalManager.update_inventory_ui.connect(update_slots)
	close()
	update_slots()


func update_slots():
	for i in range(min(player_inventory.items.size(), inventory_slots.size())):
		inventory_slots[i].update_texture(player_inventory.items[i])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			close()
		elif !get_tree().paused:
			open()
	
	if current_item == null:
		item_calories = 10
	else:
		item_calories = current_item.calories
	
	updated_calories = CalorieManager.calories + item_calories
	
	$eat_menu/ColorRect/Label.text = str(item_calories)
	
	$eat_menu/calorie_bar_updated/indicator/count.text = str(updated_calories)
	@warning_ignore_start("integer_division")
	$eat_menu/calorie_bar_updated/indicator.position.x = updated_calories / 10 
	$eat_menu/calorie_bar_updated/goal.position.x = CalorieManager.calorie_defecit / 10

func close():
	$eat_menu.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	visible = false
	is_open = false

func open():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	visible = true
	is_open = true



func _on_inventory_ui_slot_1_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[0]
	$eat_menu.visible = true

func _on_inventory_ui_slot_2_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[1]
	$eat_menu.visible = true

func _on_inventory_ui_slot_3_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[2]
	$eat_menu.visible = true

func _on_inventory_ui_slot_4_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[3]
	$eat_menu.visible = true

func _on_inventory_ui_slot_5_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[4]
	$eat_menu.visible = true

func _on_inventory_ui_slot_6_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[5]
	$eat_menu.visible = true

func _on_inventory_ui_slot_7_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[6]
	$eat_menu.visible = true

func _on_inventory_ui_slot_8_mouse_entered() -> void:
	current_item = $"../inventory_ui".player_inventory.items[7]
	
