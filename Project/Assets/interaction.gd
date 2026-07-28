extends Node2D

var interaction_progress: int = 0
var label_visible: bool = false
var can_interact: bool = false

#triggered every tick
func _process(_delta: float) -> void:
	#makes sure the label is always rotated correctly
	global_rotation = 0
	#sets the labels visibility
	if not label_visible:
		$Label.visible = false
	else:
		label_visible = false

#triggered when player is in the interaction range
func interaction_in_range():
	#shows label
	label_visible = true
	$Label.visible = true
	#checks if player starts to interact
	if Input.is_action_just_pressed("interact"):
		can_interact = true
	if Input.is_action_just_released("interact"):
		can_interact = false
	#checks if player is still interacting
	if Input.is_action_pressed("interact") and can_interact:
		interact()
	else:
		#if not still interacting reset
		interaction_progress = 0
		$Label/ColorRect.scale.x = 0

#triggered when player is in range and is interacting
func interact():
	#ups the progress
	interaction_progress += 1
	#updates the progress bar
	$Label/ColorRect.scale.x = float(interaction_progress) / 50.0
	#if it has been interacted long enough
	if interaction_progress == 50:
		#if the node it is attached top can be interacted with
		if owner.has_method("interacted_with"):
			#triggeres the function in the connected nodes script
			owner.interacted_with()
		#resets the progress
		interaction_progress = 0
