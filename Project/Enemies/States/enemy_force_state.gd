extends State

class_name EnemyForceState

func enter():
	await get_tree().create_timer(0.2).timeout
	state_machine.change_state("enemychasestate")

func physics_update(_delta: float):
	control.move_and_slide()
