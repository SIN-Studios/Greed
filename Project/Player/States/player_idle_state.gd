extends State

class_name PlayerIdleState

func enter():
	$"../../idle_timer".paused = false
	if $"../../Sprite2D".animation == "move_up":
		$"../../Sprite2D".animation = "idle_up"
	elif $"../../Sprite2D".animation == "move_down":
		$"../../Sprite2D".animation = "idle_down"
	elif $"../../Sprite2D".animation == "move_left":
		$"../../Sprite2D".animation = "idle_left"
	elif $"../../Sprite2D".animation == "move_right":
		$"../../Sprite2D".animation = "idle_right"
	else:
		$"../../Sprite2D".animation = "idle_down"

func exit():
	$"../../idle_timer".paused = true

func handle_input(event: InputEvent):
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right") or event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		state_machine.change_state("playerwalkstate")


func _on_idle_timer_timeout() -> void:
	SignalManager.player_update_calories.emit(-50)
