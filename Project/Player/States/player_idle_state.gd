extends State

class_name PlayerIdleState

func enter():
	$"../../Sprite2D".animation = "idle"

func handle_input(event: InputEvent):
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right") or event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		state_machine.change_state("playerwalkstate")
