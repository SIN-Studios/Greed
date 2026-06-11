extends Node2D

var player: CharacterBody2D
var player_in_range: bool = false
var pickup: int = 0
var label_visible: bool = false
var can_interact: bool = false


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_range = true

func _on_interaction_range_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_range = false


func _process(_delta: float) -> void:
	if not label_visible:
		$Label.visible = false
	else:
		label_visible = false

func item_in_range():
	label_visible = true
	$Label.visible = true
	if Input.is_action_just_pressed("interact"):
		can_interact = true
	if Input.is_action_just_released("interact"):
		can_interact = false

	if Input.is_action_pressed("interact") and can_interact:
		pickup_item()
	else:
		pickup = 0
		$Label/ColorRect.scale.x = 0

func pickup_item():
	pickup += 1
	$Label/ColorRect.scale.x = float(pickup) / 50.0
	if pickup == 50:
		SignalManager.player_picks_up_item.emit()
		queue_free()
		pickup = 0
