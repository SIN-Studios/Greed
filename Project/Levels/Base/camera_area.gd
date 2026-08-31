extends Area2D

func _process(delta: float) -> void:
	if overlaps_body(Global.player):
		$"..".enabled = true
		Global.player.get_node("Camera2D").enabled = false
	else:
		$"..".enabled = false
	Global.player.get_node("Camera2D").enabled = true
