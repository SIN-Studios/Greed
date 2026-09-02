extends Area2D

func _process(_delta: float) -> void:
	if overlaps_body(Global.player):
		$"..".enabled = true
		Global.player.get_node("Camera2D").enabled = false
		Global.player.get_node("knife").visible = false
	else:
		$"..".enabled = false
		Global.player.get_node("Camera2D").enabled = true
		Global.player.get_node("knife").visible = true
