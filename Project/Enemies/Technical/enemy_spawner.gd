extends Node2D

var enemy: PackedScene = preload("res://Scenes/Spawnable/Enemies/enemy.tscn")
var current_enemy: String = "dumpling"

func _on_timer_timeout() -> void:
	spawn_enemy(Vector2(randf_range(-100,100),randf_range(-100,100)))

func spawn_enemy(coordinates: Vector2) -> void:
	var new_enemy = enemy.instantiate()
	new_enemy.global_position = coordinates
	new_enemy.name = "enemy_1"
	call_deferred("add_child", new_enemy, true)
