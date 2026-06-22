extends Control

@onready var player = get_tree().get_first_node_in_group("player")
var old_health: int

func _process(_delta: float) -> void:
	if not player:
		return

	$health_indicator.self_modulate.a8 = (100 - float(player.health)) * 2.55
	if player.time_till_regen > 2:
		$health_indicator.self_modulate.r8 = 255
	else:
		$health_indicator.self_modulate.r8 = lerp($health_indicator.self_modulate.r8, 155, 0.01)
