extends PlayerState

class_name PlayerWalkState

func physics_update(_delta):
	var character = player_state_machine.get_parent()
	var direction_x = Input.get_axis("move_up", "move_down")
	var direction_y = Input.get_axis("move_left", "move_right")
	if direction_x == 0 and direction_y == 0:
		player_state_machine.change_state("playeridlestate")
		return
	character.velocity.y = direction_x * 200
	character.velocity.x = direction_y * 200
	character.move_and_slide()
