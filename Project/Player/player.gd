extends CharacterBody2D

var health: float = 100.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.0
var wake_up_position: Vector2

const LAVA_DPS: float = 20.0
const MAGMA_DPS: float = 10.0
const DAMAGE_INTERVAL: float = 0.5

var damage_timer: float = 0.0
var speed_multiplier: float = 1.0

@export var player_inventory: inventory = load("res://Inventory/players_inventory.tres")
@onready var player_state_machine: StateMachine = $StateMachine
@onready var leaf_particles = $"../decoration particles/leaf"
@onready var grass = preload("res://Sound/sfx/grass.mp3")

func _ready() -> void:
	Global.player = self
	$CPUParticles2D.emitting = false
	
func _process(delta: float) -> void:
	if velocity.length() > 0 and $leafdetector.has_overlapping_bodies():
		trigger_leaf_particles()
		AudioManager.play_sfx(grass, true)
	else:
		AudioManager.stop_sfx(grass)
		
		
	var touching_lava = $lavahurts.has_overlapping_bodies()
	var touching_magma = $magmahurts.has_overlapping_bodies()

	if touching_lava or touching_magma:
		speed_multiplier = 0.5 if touching_lava else 1.0
		damage_timer -= delta
		
		if damage_timer <= 0.0:
			damage_timer = DAMAGE_INTERVAL
			var dps = LAVA_DPS if touching_lava else MAGMA_DPS
			health -= dps * DAMAGE_INTERVAL
			
			var shake_intensity = 0.9 if touching_lava else 0.7
			SignalManager.shake_requested.emit(shake_intensity)
			
			$CPUParticles2D.restart()
			$CPUParticles2D.emitting = true
			
			if health <= 0:
				player_state_machine.change_state("playerdiesstate")
	else:
		# Reset mechanics when completely outside hazards
		speed_multiplier = 1.0
		damage_timer = 0.0
		$CPUParticles2D.emitting = false
		
		if SignalManager.has_signal("shake_stop_requested"):
			SignalManager.shake_stop_requested.emit()

	# Regeneration System
	if time_till_regen > 0:
		time_till_regen -= delta
		return

	if health < 100 and not touching_lava and not touching_magma:
		health += regen_factor * delta
		regen_factor += 2.0 * delta
		if health > 100:
			health = 100

func trigger_leaf_particles() -> void:
	if not leaf_particles:
		AudioManager.stop_sfx(grass)
		return
		
	leaf_particles.global_position = global_position
	if not leaf_particles.emitting:
		leaf_particles.restart()
		leaf_particles.emitting = true
