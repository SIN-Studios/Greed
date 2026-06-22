extends CharacterBody2D


const speed: int = 125
const slipperiness_factor: int = 10 #Higher is more slippery
var health: float = 100.0
var time_till_regen: float = 0.0
var regen_factor: float = 0.1

func _ready() -> void:
	SignalManager.player_take_damage.connect(take_damage)

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
	time_till_regen = 1
	print("Player", health)
	if health <= 0:
		get_tree().quit()
