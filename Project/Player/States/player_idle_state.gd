extends PlayerState

class_name PlayerIdleState

func enter():
	print("entering idle")

func handle_input(_event: InputEvent):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_just_pressed("move_up") or Input.is_action_pressed("move_down"):
		player_state_machine.change_state("playerwalkstate")
		print("exiting idle")
