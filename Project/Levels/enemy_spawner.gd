extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@onready var tile_map_layer: TileMapLayer = $"../tilemaps/tilemap"

var tiles: Array[Vector2i] = []
var enemy_count: int

func _ready() -> void:
	SignalManager.first_enemy_killed.connect(timer_start)
	tiles = tile_map_layer.get_used_cells()
	
	tiles = tiles.filter(func(cell):
		var tile_data: TileData = tile_map_layer.get_cell_tile_data(cell)
		if tile_data != null:
			return tile_data.get_custom_data("enemy_spawns") == true
		return false
	)


func timer_start():
	$Timer.start()
	for i in range(0, randi_range(5, 10)):
		spawn_enemy()

func spawn_enemy() -> void:
	if tiles.is_empty():
		return
	var random_cell: Vector2i = tiles.pick_random()
	var local_pos: Vector2 = tile_map_layer.map_to_local(random_cell)
	var global_pos: Vector2 = tile_map_layer.to_global(local_pos)
	var enemy_instance = enemy_scenes.pick_random().instantiate()
	enemy_count += 1
	enemy_instance.name = enemy_instance.name + "_" + str(enemy_count)
	get_tree().current_scene.add_child(enemy_instance)
	enemy_instance.global_position = global_pos



func _on_timer_timeout() -> void:
	spawn_enemy()
