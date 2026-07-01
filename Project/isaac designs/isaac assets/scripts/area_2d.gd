extends Area2D

@export var destination_scene: String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		# Fallback to homebase if the export variable was left blank in the inspector
		var target = destination_scene if destination_scene != "" else "res://Levels/main_level.tscn"
		trigger_transition(target)

func trigger_transition(target_path: String):
	var transition_scene = preload("res://UI/transition.tscn")
	if transition_scene:
		var transition = transition_scene.instantiate()
		# Add it to the root so it persists across scene changes
		get_tree().get_root().add_child(transition)
		# Start the animation sequence
		transition.slide_and_change_scene(target_path)
