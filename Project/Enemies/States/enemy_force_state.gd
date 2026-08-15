extends State

class_name EnemyForceState

func enter():
	await get_tree().create_timer(0.2).timeout
	state_machine.change_state("enemychasestate")

func physics_update(delta: float):
	control.velocity = control.velocity.move_toward(Vector2.ZERO, 1000.0 * delta)
	control.move_and_slide()

func exit():
	control.modulate = Color8(255, 255, 255, 255)
