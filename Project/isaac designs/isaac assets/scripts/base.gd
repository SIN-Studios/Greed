extends Area2D
func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body is the player
	if body.name == "player": # Or use a class_name like: if body is Player:
		get_tree().change_scene_to_file.call_deferred("res://Levels/homebase.tscn")
