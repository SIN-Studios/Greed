extends CharacterBody2D

const speed: int = 100
var current_speed: int
var speed_multuplier: int = 1
const slipperiness_factor: int = 10 #Higher is more slippery
const enemy_damage: int = 10
var direction: Vector2
var player: Node2D 
var health: int = 100

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	current_speed = speed
	SignalManager.enemy_take_damage.connect(take_damage)

func _physics_process(_delta: float) -> void:
	direction = global_position.direction_to(player.global_position)
	velocity = direction * speed * speed_multuplier
	if speed_multuplier != 1:
		speed_multuplier += 1
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		#give player damage
		var new_damage = enemy_damage * randf_range(0.8, 1.2)
		SignalManager.player_take_damage.emit(new_damage)
		
func take_damage(damage):
	print("enemy ", health)
	health -= damage
	if health <= 0:
		print("enemy died")
		
		
	#knockback enemy
	speed_multuplier = -10
