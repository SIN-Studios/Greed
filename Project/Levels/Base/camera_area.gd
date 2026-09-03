extends Area2D

func _process(_delta: float) -> void:
	if overlaps_body(Global.player):
		Global.in_base = true
		$"..".enabled = true
		Global.player.get_node("Camera2D").enabled = false
		Global.player.get_node("knife").visible = false
	else:
		Global.in_base = false
		$"..".enabled = false
		Global.player.get_node("Camera2D").enabled = true
		Global.player.get_node("knife").visible = true
