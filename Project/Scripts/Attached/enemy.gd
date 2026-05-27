extends CharacterBody2D

const speed: int = 100
var current_speed: int
var speed_multuplier: int = 1
const slipperiness_factor: int = 10 #Higher is more slippery
const damage: int = 10
var direction: Vector2
var player: Node2D 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	current_speed = speed

func _physics_process(delta: float) -> void:
	direction = global_position.direction_to(player.global_position)
	velocity = direction * speed * speed_multuplier
	if speed_multuplier != 1:
		speed_multuplier += 1
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		#give player damage
		var new_damage = damage * randf_range(0.8, 1.2)
		SignalManager.player_take_damage.emit(new_damage)
		#knockback enemy
		speed_multuplier = -10
