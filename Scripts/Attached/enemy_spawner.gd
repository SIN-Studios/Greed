extends Node2D

var enemy: PackedScene = preload("res://Scenes/Spawnable/enemy.tscn")
var current_enemy: String = "dumpling"

var enemies: Dictionary[String, ItemData] = {
	"dumpling": create_item("Dumpling", preload("res://Assets/Sprites/icon.svg"), preload("res://Scripts/Attached/Enemies/enemy.gd"))
}

func create_item(enemy_name: String, enemy_texture: Texture2D, enemy_script: Script) -> ItemData:
	var enemy_data = ItemData.new()
	enemy_data.enemy_name = enemy_name
	enemy_data.enemy_texture = enemy_texture
	enemy_data.enemy_script = enemy_script
	return enemy_data

func _on_timer_timeout() -> void:
	spawn_enemy(Vector2(randf_range(-100,100),randf_range(-100,100)))

func spawn_enemy(coordinates: Vector2) -> void:
	var new_enemy = enemy.instantiate()
	new_enemy.global_position = coordinates
	new_enemy.name = str(enemies[current_enemy].enemy_name, "_1")
	new_enemy.get_node("Sprite2D").texture = enemies[current_enemy].enemy_texture
	new_enemy.script = enemies[current_enemy].enemy_script
	call_deferred("add_child", new_enemy, true)
