extends Node

var calories: int
var max_calories: int = 4500
var calorie_defecit: int 
var hunger_zones = [
	{"range": Vector2(0, 1500), "state": "dead"},
	{"range": Vector2(1500, 2000), "state": "unhealthy"},
	{"range": Vector2(2000, 2500), "state": "healthy"},
	{"range": Vector2(2500, 3000), "state": "unhealthy"},
	{"range": Vector2(3000, 4500), "state": "dead"}
]
var calories_middle: int = 2250
var calories_max: int = 4500

func _ready() -> void:
	SignalManager.player_update_calories.connect(player_update_calories)
	SignalManager.new_day.connect(check_hunger)


func player_update_calories(amount):
	calories += amount
	if calories < 0 or calories > calories_max:
		SignalManager.player_dies.emit()


func check_hunger():
	var updated_calories = calories - calorie_defecit
	for zone in hunger_zones:
		if updated_calories >= zone["range"].x and updated_calories <= zone["range"].y:
			apply_effect(zone["state"])
			break
	calories = 0

func apply_effect(state):
	match state:
		"dead":
			SignalManager.player_dies.emit()
		"unhealthy":
			calorie_defecit += calories_middle - calories
		"healthy":
			calorie_defecit = 0
