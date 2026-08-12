extends CharacterBody2D


var health: float = 100.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.0
var wake_up_position: Vector2

@export var player_inventory: inventory = load("res://Inventory/players_inventory.tres")

func _ready() -> void:
	SignalManager.player_take_damage.connect(take_damage)
	SignalManager.player_dies.connect(die)
	SignalManager.player_lay_down.connect(lie_down)
	SignalManager.player_go_to_sleep.connect(sleep)
	SignalManager.player_get_up.connect(get_up)
	Global.player = self

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
		take_damage(35, Vector2(0,0))

func _on_magmahurts_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		take_damage(20, Vector2(0,0))

func take_damage(damage, direction):
	health -= damage
	velocity += direction * 200
	regen_factor = 0.1
	time_till_regen = 5
	print("Player", health)
	if health <= 0:
		SignalManager.player_dies.emit()

func die():
	print("player died")
	get_tree().quit()

func lie_down(bed):
	set_physics_process(false)
	wake_up_position = global_position
	global_position = bed.global_position
	rotation = bed.rotation

func sleep():
	TimeManager.timescale = 3000

func get_up():
	global_position = wake_up_position
	rotation = 0
	TimeManager.timescale = 120
