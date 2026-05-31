extends Node2D

var player: CharacterBody2D 
const speed: float = 1.5
var acceleration: float
var player_in_range: bool = false
var pickup: int = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true

func _on_interaction_range_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false

func _process(_delta: float) -> void:
	if player_in_range:
		$Label.visible = true
		if Input.is_action_pressed("interact"):
			pickup += 1
			$Label/ColorRect.scale.x = float(pickup) / 50.0
			if pickup == 50:
				SignalManager.player_picks_up_item.emit()
				queue_free()
				pickup = 0
		else:
			pickup = 0
	else:
		$Label.visible = false
		pickup = 0


func _on_timer_timeout() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$Timer.start()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$Timer.stop()
