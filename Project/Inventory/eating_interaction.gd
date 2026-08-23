extends Label

var interaction_progress: int = 0
var can_interact: bool = true


#triggered when player is in the interaction range
func _process(_delta: float) -> void:
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
		$ColorRect.scale.x = 0

#triggered when player is in range and is interacting
func interact():
	#ups the progress
	interaction_progress += 1
	#updates the progress bar
	$ColorRect.scale.x = float(interaction_progress) / 50.0
	#if it has been interacted long enough
	if interaction_progress == 50:
		#triggeres the function in the connected nodes script
		$"../../..".interacted_with()
		#resets the progress
		interaction_progress = 0
