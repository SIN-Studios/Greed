extends Node

var all_time_calories: int
var calories: int = 2250
var max_calories: int = 4500
var calorie_defecit: int 
var hunger_zones: Array = [
	{"range": Vector2(0, 1500), "state": "dead"},
	{"range": Vector2(1500, 2000), "state": "unhealthy"},
	{"range": Vector2(2000, 2500), "state": "healthy"},
	{"range": Vector2(2500, 3000), "state": "unhealthy"},
	{"range": Vector2(3000, 4500), "state": "dead"}
]
var calories_middle: int = 2250
var calories_max: int = 4500

#trigered when game starts
func _ready() -> void:
	#connects signals from 'SignalManager' to the script
	SignalManager.player_update_calories.connect(player_update_calories)
	SignalManager.new_day.connect(check_hunger)

#triggered when player eats food 
func player_update_calories(amount):
	#adds calories to the total
	calories += amount
	all_time_calories += amount
	print(all_time_calories)
	#checks if the player should die from exceding the bar fully, is an instant death
	if calories < 0 or calories > calories_max:
		SignalManager.player_dies.emit()

#triggered at 12:00am when it becomes a new day
func check_hunger():
	#works out how many calories the player has relative to the calorie defecit
	var updated_calories = calories - calorie_defecit
	for zone in hunger_zones:
		#applies the effect depending on how much food you ate
		if updated_calories >= zone["range"].x and updated_calories <= zone["range"].y:
			apply_effect(zone["state"])
			break

func apply_effect(state):
	match state:
		#player has had to little or too much food
		"dead":
			SignalManager.player_dies.emit()
		#player has had slightly to little or to much food so it will come use or store it as fat
		"unhealthy":
			calorie_defecit += calories_middle - calories
		#player ate a good amount of food no consequence
		"healthy":
			calorie_defecit = 0
