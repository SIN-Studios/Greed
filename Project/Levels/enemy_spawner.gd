extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@onready var tile_map_layer: TileMapLayer = $"../tilemaps/tilemap"
var enemy_count: int

var spawn_tiles: Array[Vector2i] = []

func _ready() -> void:
	SignalManager.first_enemy_killed.connect(timer_start)
	for cell in tile_map_layer.get_used_cells():
		var tile_data: TileData = tile_map_layer.get_cell_tile_data(cell)
		if tile_data != null and tile_data.get_custom_data("enemy_spawns") == true:
			spawn_tiles.append(cell)

func spawn_enemy(chosen_enemy) -> void:
	if not is_instance_valid(Global.player) or spawn_tiles.is_empty():
		return

	var player_local = tile_map_layer.to_local(Global.player.global_position)
	var player_cell: Vector2i = tile_map_layer.local_to_map(player_local)
	var min_tile_distance: float = 15.0

	var valid_spawns = spawn_tiles.filter(func(cell: Vector2i):
		return Vector2(cell).distance_to(Vector2(player_cell)) >= min_tile_distance
	)

	if valid_spawns.is_empty():
		return

	var random_tile = valid_spawns.pick_random()
	var local_pos = tile_map_layer.map_to_local(random_tile)
	var spawn_pos = tile_map_layer.to_global(local_pos)

	var enemy_instance
	if chosen_enemy != null:
		enemy_instance = chosen_enemy.instantiate()
	else:
		enemy_instance = enemy_scenes.pick_random().instantiate()

	enemy_count += 1
	enemy_instance.name = enemy_instance.name + "_" + str(enemy_count)
	enemy_instance.global_position = spawn_pos

	get_tree().current_scene.add_child(enemy_instance)




func timer_start():
	$Timer.start()
	for i in randi_range(10, 20):
		spawn_enemy(enemy_scenes.get(0))
	for i in randi_range(5, 10):
		spawn_enemy(enemy_scenes.get(2))
	for i in randi_range(0, 2):
		spawn_enemy(enemy_scenes.get(3))
	for i in randi_range(5, 10):
		spawn_enemy(enemy_scenes.get(4))
	for i in randi_range(5, 10):
		spawn_enemy(enemy_scenes.get(5))

func _on_timer_timeout() -> void:
	spawn_enemy(null)
