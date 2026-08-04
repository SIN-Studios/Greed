extends State

class_name EnemyDiesState

@onready var item_scene = preload("res://Assets/item.tscn")


func enter():
	var dropped_item = item_scene.instantiate()
	dropped_item.item = control.current_enemy
	dropped_item.global_position = control.global_position
	control.get_parent().add_child.call_deferred(dropped_item)
	control.queue_free()
