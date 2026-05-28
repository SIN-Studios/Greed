extends CharacterBody2D


const speed: int = 125
const slipperiness_factor: int = 10 #Higher is more slippery
var health: int = 100

func _ready() -> void:
	SignalManager.player_take_damage.connect(take_damage)

func _physics_process(_delta: float) -> void:
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, slipperiness_factor)
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, slipperiness_factor)
	move_and_slide()

func take_damage(damage):
	print(health)
	health -= damage
	if health <= 0:
		print("You died")
