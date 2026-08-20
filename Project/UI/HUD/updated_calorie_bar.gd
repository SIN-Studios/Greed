extends Control

#could be made into a function called from another script only when needed rather than checking every tick
#triggered every tick
func _process(_delta: float) -> void:
	#changes the displayed text to match the calorie count
	$indicator/count.text = str(CalorieManager.calories)
	@warning_ignore_start("integer_division")
	#calculates the position of the bar which indicates the calorie count
	$indicator.position.x = CalorieManager.calories / 10 
	#calculates the position of the goal section(green and blue) based on the players calorie defecit from the day before
	$goal.position.x = CalorieManager.calorie_defecit / 10
