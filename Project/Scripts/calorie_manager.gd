extends Node

var calories: int
var max_calories

func _ready() -> void:
	SignalManager.player_update_calories.connect(player_update_calories)

func player_update_calories(amount):
	calories += amount
