extends State

class_name EnemyDamageState

func _ready() -> void:
	SignalManager.enemy_take_damage.connect(take_damage)

func enter():
	if !control:
		return

func take_damage(damage, direction, body):
	if body != control:
		return
	state_machine.change_state("enemydamagestate")
	control.health -= damage
	control.velocity += direction * 200
	control.move_and_slide()
	await get_tree().create_timer(0.5).timeout
	control.move_and_slide()
	if control.health <= 0:
		state_machine.change_state("enemydiesstate")
	else:
		state_machine.change_state("enemychasestate")
