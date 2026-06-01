extends CharacterBody2D

const speed: int = 100
var current_speed: int
var speed_multuplier: int = 1
const slipperiness_factor: int = 10 #Higher is more slippery
const enemy_damage: int = 10
var direction: Vector2
var player: CharacterBody2D 
var health: int = 100
var following_player: bool = false

var item: PackedScene = preload("res://Scenes/Spawnable/item.tscn")

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	current_speed = speed
	SignalManager.enemy_take_damage.connect(take_damage)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	if not following_player:
		velocity = Vector2.ZERO
		return

	direction = global_position.direction_to(player.global_position)
	velocity = direction * speed * speed_multuplier
	if speed_multuplier != 1:
		speed_multuplier += 1
	else:
		set_collision_mask_value(4, true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		#give player damage
		var new_damage = enemy_damage * randf_range(0.8, 1.2)
		SignalManager.player_take_damage.emit(new_damage)


func take_damage(damage, body) -> void:
	if body == self:
		print("enemy ", health)
		health -= damage
		if health <= 0:
			enemy_die()
		#knockback enemy
		speed_multuplier = -10
		set_collision_mask_value(4, false)

func enemy_die() -> void:
	summon_item()
	queue_free()

func summon_item() -> void:
	var new_item = item.instantiate()
	new_item.global_position = global_position
	call_deferred("add_sibling", new_item)


func _on_detection_range_body_entered(body: Node2D) -> void:
	if body == player:
		following_player = true

func _on_focus_range_body_exited(body: Node2D) -> void:
	if body == player:
		following_player = false


func _on_timer_timeout() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$Timer.start()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$Timer.stop()
