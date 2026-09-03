extends Control

@onready var player = Global.player

#triggered every tick
func _process(_delta: float) -> void:
	#makes sure player exists
	if not player:
		player = Global.player
		return
	#fades the health vignette
	$health_indicator.modulate.a8 = (player.max_health - float(player.health)) * 255 / player.max_health
	if player.time_till_regen > 2:
		#lightens the vignette when player takes damage
		$health_indicator.modulate.r8 = 255
	else:
		#darkeness the vignette when player starts healing
		$health_indicator.modulate.r8 = lerp($health_indicator.modulate.r8, 155, 0.01)
	#changes vignette to the frame depending on the players health
	$health_indicator.frame = clampi(floor((player.health / player.max_health) * 4), 0, 3)
	var tween = create_tween()
	if (player.health - 90) < 0:
		tween.tween_property($ColorRect, "color", Color8(255, 0, 0, 100), 1.0)
	else:
		tween.tween_property($ColorRect, "color", Color8(255, 0, 0, 0), 1.0)
