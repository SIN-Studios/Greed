extends CharacterBody2D


const speed: int = 125
const slipperiness_factor: int = 10 #Higher is more slippery
var health: float = 100.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.
var wake_up_position

@export var player_inventory: inventory = load("res://UI/Inventory/players_inventory.tres")

func _ready() -> void:
	SignalManager.player_take_damage.connect(take_damage)
	SignalManager.player_dies.connect(die)
	SignalManager.player_lay_down.connect(lie_down)
	SignalManager.player_go_to_sleep.connect(sleep)
	SignalManager.player_get_up.connect(get_up)
	SignalManager.player_picks_up_item.connect(pickup_item)

func _process(delta: float) -> void:
	if time_till_regen > 0:
		time_till_regen -= delta
		return

	if health < 100:
		health += regen_factor * delta
		regen_factor += 2.0 * delta 
		if health > 100:
			health = 100


func _physics_process(_delta: float) -> void:
	var direction_x := Input.get_axis("move_left", "move_right")
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, slipperiness_factor)
	var direction_y := Input.get_axis("move_forward", "move_backward")
	if direction_y:
		velocity.y = direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, slipperiness_factor)
	move_and_slide()

func take_damage(damage):
	health -= damage
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

func pickup_item(item):
	print(item)
	player_inventory.pickup_item(item)
	
