extends Node2D

var interaction_progress: int = 0
var label_visible: bool = false
var can_interact: bool = false


func _process(_delta: float) -> void:
	if not label_visible:
		$Label.visible = false
	else:
		label_visible = false

func interaction_in_range():
	label_visible = true
	$Label.visible = true
	if Input.is_action_just_pressed("interact"):
		can_interact = true
	if Input.is_action_just_released("interact"):
		can_interact = false

	if Input.is_action_pressed("interact") and can_interact:
		interact()
	else:
		interaction_progress = 0
		$Label/ColorRect.scale.x = 0

func interact():
	interaction_progress += 1
	$Label/ColorRect.scale.x = float(interaction_progress) / 50.0
	if interaction_progress == 50:
		if owner.has_method("interacted_with"):
			owner.interacted_with()
		interaction_progress = 0
