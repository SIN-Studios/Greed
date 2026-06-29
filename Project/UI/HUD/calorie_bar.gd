extends Control

func _process(_delta: float) -> void:
	$indicator/count.text = str(CalorieManager.calories)
	@warning_ignore_start("integer_division")
	$indicator.position.x = CalorieManager.calories / 10 
	$goal.position.x = CalorieManager.calorie_defecit / 10
