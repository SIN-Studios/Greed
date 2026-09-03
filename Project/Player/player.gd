extends CharacterBody2D

var t_delta: float = 0.0
var health: float = 100.0
var max_health: float = 250.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.0
var wake_up_position: Vector2
const speed: int = 100

const LAVA_DPS: float = 20.0
const MAGMA_DPS: float = 10.0
const DAMAGE_INTERVAL: float = 0.5

var damage_timer: float = 0.0
var speed_multiplier1: float = 1.0
var speed_multiplier2: float = 1.0
var speed_multiplier3: float = 1.0

@export var player_inventory: inventory = load("res://Inventory/players_inventory.tres")
@onready var player_state_machine: StateMachine = $StateMachine
@onready var leaf_particles = $"../decoration particles/leaf"
@onready var grass = preload("res://Sound/sfx/grass.mp3")

func _ready() -> void:
	SignalManager.new_day.connect(new_day)
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
		speed_multiplier1 = 0.5 if touching_lava else 1.0
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
		speed_multiplier1 = 1.0
		damage_timer = 0.0
		$CPUParticles2D.emitting = false
		
		if SignalManager.has_signal("shake_stop_requested"):
			SignalManager.shake_stop_requested.emit()

	# Regeneration System
	if time_till_regen > 0:
		time_till_regen -= delta
		return

	if health < max_health and not touching_lava and not touching_magma and time_till_regen <= 0:
		health += regen_factor * delta
		regen_factor += 2.0 * delta
		t_delta += delta
		if t_delta > 1:
			t_delta = 0
			SignalManager.player_update_calories.emit(-50)
		if health > max_health:
			health = max_health
			regen_factor = 0.0

func new_day():
	if max_health > 100:
		max_health -= 50

func trigger_leaf_particles() -> void:
	if not leaf_particles:
		AudioManager.stop_sfx(grass)
		return
		
	leaf_particles.global_position = global_position
	if not leaf_particles.emitting:
		leaf_particles.restart()
		leaf_particles.emitting = true
