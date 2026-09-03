extends State

class_name PlayerHurtState

var damage: int
var direction: Vector2
@onready var death = preload("res://Sound/sfx/enemy death.mp3")

func take_damage(input_damage, input_direction):
	damage = input_damage
	direction = input_direction
	state_machine.change_state("playerhurtstate")
	SignalManager.shake_requested.emit(0.5) 
	$"../../CPUParticles2D".restart()

func enter():
	control.get_node("Sprite2D").modulate = Color8(255, 0, 0, 200)
	control.health -= damage
	control.time_till_regen = 8
	control.velocity += direction
	await get_tree().create_timer(0.2).timeout
	if control.health <= 0:
		state_machine.change_state("playerdiesstate")
		AudioManager.play_sfx(death, true)
	else:
		state_machine.change_state("playeridlestate")

func physics_update(delta: float):
	control.velocity = control.velocity.move_toward(Vector2.ZERO, 1000.0 * delta)
	control.move_and_slide()

func exit():
	control.get_node("Sprite2D").modulate = Color8(255, 255, 255, 255)
