extends State

class_name PlayerHurtState

var damage: int
var direction: Vector2

func take_damage(input_damage, input_direction):
	damage = input_damage
	direction = input_direction
	SignalManager.shake_requested.emit(0.7) 
	state_machine.change_state("playerhurtstate")

func enter():
	control.modulate = Color8(255, 0, 0, 200)
	control.health -= damage
	control.velocity += direction
	await get_tree().create_timer(0.2).timeout
	if control.health <= 0:
		state_machine.change_state("playerdiesstate")
	else:
		state_machine.change_state("playeridlestate")

func physics_update(delta: float):
	control.velocity = control.velocity.move_toward(Vector2.ZERO, 1000.0 * delta)
	control.move_and_slide()

func exit():
	control.modulate = Color8(255, 255, 255, 255)
