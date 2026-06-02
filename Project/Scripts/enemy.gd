extends CharacterBody2D

const speed: int = 225
const slipperiness_factor: int = 10 #Higher is more slippery

var player: Node2D 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
