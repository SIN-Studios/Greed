extends State

class_name PlayerIdleState


func handle_input(event: InputEvent):
	if event.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_just_pressed("move_up") or Input.is_action_pressed("move_down"):
		state_machine.change_state("playerwalkstate")
