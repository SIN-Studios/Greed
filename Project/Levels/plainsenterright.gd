extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.global_position.x > global_position.x:
			SignalManager.plains.emit()
