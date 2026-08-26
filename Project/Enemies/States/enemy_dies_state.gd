extends State

class_name EnemyDiesState

@onready var item_scene = preload("res://Assets/item.tscn")


func enter():
	if state_machine.last_state != get_node("../EnemyExplodeState"):
		drop_item()
	control.queue_free()

func drop_item():
	var dropped_item = item_scene.instantiate()
	dropped_item.item = control.current_enemy
	dropped_item.global_position = control.global_position
	control.get_parent().add_child.call_deferred(dropped_item)
