extends State

class_name PlayerWalkState

const slipperiness_factor: int = 5 #higher is more slippery
var last_animation: String

func enter():
	$"../../walk_timer".paused = false

func exit():
	$"../../walk_timer".paused = true

func update(_delta: float):
	if control.velocity.x == 0 and control.velocity.y == 0:
		state_machine.change_state("playeridlestate")
	elif control.velocity.x < 0:
		last_animation = "move_left"
		$"../../Sprite2D".animation = "move_left"
	elif control.velocity.x > 0:
		$"../../Sprite2D".animation = "move_right"
		last_animation = "move_right"
	elif control.velocity.y < 0:
		$"../../Sprite2D".animation = "move_up"
		last_animation = "move_up"
	elif control.velocity.y > 0:
		$"../../Sprite2D".animation = "move_down"
		last_animation = "move_down"


func physics_update(_delta):
	var current_speed = control.speed * control.speed_multiplier1 * control.speed_multiplier2 * control.speed_multiplier3
	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_up", "move_down")
	if direction_x:
		control.velocity.x = direction_x * current_speed
	else:
		control.velocity.x = move_toward(control.velocity.x, 0, slipperiness_factor)
	if direction_y:
		control.velocity.y = direction_y * current_speed
	else:
		control.velocity.y = move_toward(control.velocity.y, 0, slipperiness_factor)
	control.move_and_slide()


func _on_walk_timer_timeout() -> void:
		SignalManager.player_update_calories.emit(-50)
