extends CharacterBody2D


var health: float = 100.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.0
var wake_up_position: Vector2

@export var player_inventory: inventory = load("res://Inventory/players_inventory.tres")
@onready var player_state_machine: StateMachine = $StateMachine

func _ready() -> void:
	Global.player = self
	$CPUParticles2D.emitting = false
func _process(delta: float) -> void:
	if time_till_regen > 0:
		time_till_regen -= delta
		return

	if health < 100:
		health += regen_factor * delta
		regen_factor += 2.0 * delta 
		if health > 100:
			health = 100

func _on_lavahurts_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		get_node("StateMachine/PlayerHurtState").take_damage(34, Vector2(0,0))

func _on_magmahurts_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		get_node("StateMachine/PlayerHurtState").take_damage(20, Vector2(0,0))
