extends Node

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("damage"):
		SignalManager.player_take_damage.emit(20)
	
	if Input.is_action_just_pressed("eat"):
		SignalManager.player_update_calories.emit(20)

	if Input.is_action_just_pressed("starve"):
		SignalManager.player_update_calories.emit(-20)
