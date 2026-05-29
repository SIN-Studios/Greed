extends Node2D

var player: CharacterBody2D 
const speed: int = 1.5
var acceleration: float
var player_in_range: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _on_area_2d_body_entered(body: Node2D) -> void:
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
		print(distance_to_player)
		global_position += direction * speed * delta * (200 - distance_to_player)
