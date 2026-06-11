extends Node2D

var items_are_in_range: bool = false
var previous_item: Node2D = null


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click"):
		pass
	if items_are_in_range:
		test_for_pickup()

func _on_interaction_range_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if is_instance_valid(area) and area.is_in_group("items"):
		items_are_in_range = true

func _on_interaction_range_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if is_instance_valid(area) and area.is_in_group("items") and $interaction_range.get_overlapping_areas().is_empty():
		items_are_in_range = false


func test_for_pickup():
	var overlapping_items = $interaction_range.get_overlapping_areas()
	var closest_item: Node2D = null
	var smallest_distance: float = INF

	for item in overlapping_items:
		var distance: float = global_position.distance_squared_to(item.global_position)
		if distance < smallest_distance:
			smallest_distance = distance
			closest_item = item

	if not is_instance_valid(closest_item):
		return
	if not is_instance_valid(closest_item.owner):
		return


	if closest_item.owner.has_method("item_in_range"):
		closest_item.owner.item_in_range()
