extends Area2D

@export var destination_scene: String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var target = destination_scene if destination_scene != "" else "res://Levels/homebase.tscn"
		trigger_transition(target)

func trigger_transition(target_path: String):
	var transition_scene = preload("res://UI/transition.tscn")
	if transition_scene:
		var transition = transition_scene.instantiate()
		get_tree().get_root().add_child(transition)
		transition.slide_and_change_scene(target_path)
