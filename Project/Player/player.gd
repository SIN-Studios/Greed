extends CharacterBody2D

var health: float = 100.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.0
var wake_up_position: Vector2

const LAVA_DPS: float = 20.0
const MAGMA_DPS: float = 10.0
const DAMAGE_INTERVAL: float = 0.5

var in_lava: bool = false
var in_magma: bool = false
var damage_timer: float = 0.0
var speed_multiplier: float = 1.0

@export var player_inventory: inventory = load("res://Inventory/players_inventory.tres")
@onready var player_state_machine: StateMachine = $StateMachine
@onready var tilemap = $"../tilemaps/decorations"
@onready var leaf_particles = $"../decoration particles/leaf"

func _ready() -> void:
	Global.player = self
	$CPUParticles2D.emitting = false
	
func _process(delta: float) -> void:
	if velocity.length() > 0:
		if $leafdetector.has_overlapping_bodies():
			trigger_leaf_particles()
		
	var touching_lava = $lavahurts.has_overlapping_bodies()
	var touching_magma = $magmahurts.has_overlapping_bodies()
	
	if touching_lava or touching_magma:
		if touching_lava:
			speed_multiplier = 0.5
		else:
			speed_multiplier = 0.7
			
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
		speed_multiplier = 1.0
		damage_timer = 0.0

	if time_till_regen > 0:
		time_till_regen -= delta
		return

	if health < 100 and !in_lava and !in_magma:
		health += regen_factor * delta
		regen_factor += 2.0 * delta
		if health > 100:
			health = 100

func trigger_leaf_particles() -> void:
	if not leaf_particles:
		return
		
	print("Found leaves! Spawning particles...") # <--- ADD THIS
	
	leaf_particles.global_position = global_position
	if not leaf_particles.emitting:
		leaf_particles.restart()
		leaf_particles.emitting = true
		


func _on_lavahurts_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		in_lava = true
		damage_timer = 0.0

func _on_lavahurts_body_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		in_lava = false

func _on_magmahurts_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		in_magma = true
		damage_timer = 0.0

func _on_magmahurts_body_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		in_magma = false
