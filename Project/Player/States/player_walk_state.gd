extends PlayerState

class_name PlayerWalkState

const speed: int = 75
const slipperiness_factor: int = 5 #higher is more slippery

func physics_update(_delta):
	var player = player_state_machine.get_parent()
	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_up", "move_down")
	if direction_x:
		player.velocity.x = direction_x * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, slipperiness_factor)
	if direction_y:
		player.velocity.y = direction_y * speed
	else:
		player.velocity.y = move_toward(player.velocity.y, 0, slipperiness_factor)
	player.move_and_slide()
