extends CharacterBody2D


const speed: int = 125
const slipperiness_factor: int = 10 #Higher is more slippery
var health: int = 100
var time_till_regen: int = 0
var regen_factor: float = 0.1
var regen_gap: int = 0

func _ready() -> void:
	SignalManager.player_take_damage.connect(take_damage)

func _process(_delta: float) -> void:
	if time_till_regen < 0:
		if health < 100 and regen_gap == 0:
			@warning_ignore("narrowing_conversion")
			health += regen_factor
			regen_factor = regen_factor * 1.1
			@warning_ignore("narrowing_conversion")
			regen_gap = 50 * regen_factor
			if health > 100:
				health = 100
			print(health)
		elif regen_gap > 0:
			regen_gap -= 1
	else:
		time_till_regen -= 1


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
	time_till_regen = 200
	print(health)
	if health <= 0:
		print("You died")
