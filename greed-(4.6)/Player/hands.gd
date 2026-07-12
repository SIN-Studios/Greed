extends Node2D

var interaction_in_range: bool = false
var previous_item: Node2D = null


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click"):
		pass
	if interaction_in_range:
		test_for_interact()

func _on_interaction_range_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if is_instance_valid(area) and area.is_in_group("interactables"):
		interaction_in_range = true

func _on_interaction_range_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if is_instance_valid(area) and area.is_in_group("interactables") and $interaction_range.get_overlapping_areas().is_empty():
		interaction_in_range = false


func test_for_interact():
	var overlapping_interactables = $interaction_range.get_overlapping_areas()
	var closest_interactable: Node2D = null
	var smallest_distance: float = INF

	for interactable in overlapping_interactables:
		var distance: float = global_position.distance_squared_to(interactable.global_position)
		if distance < smallest_distance:
			smallest_distance = distance
			closest_interactable = interactable

	if not is_instance_valid(closest_interactable):
		return
	if not is_instance_valid(closest_interactable.owner):
		return


	if closest_interactable.owner.has_method("interaction_in_range"):
		closest_interactable.owner.interaction_in_range()
