extends State

class_name PlayerIdleState


func handle_input(event: InputEvent):
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		state_machine.change_state("playerwalkstate")
	if event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		state_machine.change_state("playerwalkstate")
