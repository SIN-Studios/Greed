extends State

class_name EnemyDamageState

var damage: int
var direction: Vector2

func take_damage(input_damage, input_direction):
	state_machine.change_state("enemydamagestate")
	damage = input_damage
	direction = input_direction

func enter():
	control.modulate = Color8(255, 0, 0, 200)
	control.health -= damage
	control.velocity += direction
	if control.health <= 0:
		state_machine.change_state("enemydiesstate")
	else:
		state_machine.change_state("enemyforcestate")
