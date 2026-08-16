extends Control

@onready var player = Global.player

#triggered every tick
func _process(_delta: float) -> void:
	#makes sure player exists
	if not player:
		player = Global.player
		return
	#fades the health vignette
	$health_indicator.modulate.a8 = (100 - float(player.health)) * 2.55
	if player.time_till_regen > 2:
		#lightens the vignette when player takes damage
		$health_indicator.modulate.r8 = 255
	else:
		#darkeness the vignette when player starts healing
		$health_indicator.modulate.r8 = lerp($health_indicator.modulate.r8, 155, 0.01)
	#changes vignette to the frame depending on the players health
	$health_indicator.frame = floor(player.health / 25)
