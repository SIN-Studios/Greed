extends Node2D

var player: CharacterBody2D 
const speed: float = 1.5
var acceleration: float
var player_in_range: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		SignalManager.player_picks_up_item.emit()
		queue_free()


func _on_collection_range_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true

func _on_collection_range_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false

func _physics_process(delta: float) -> void:
	if player_in_range:
		var direction = global_position.direction_to(player.global_position)
		var distance_to_player = global_position.distance_to(player.global_position)
		global_position += direction * speed * delta * (200 - distance_to_player)


func _on_timer_timeout() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$Timer.start()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$Timer.stop()
