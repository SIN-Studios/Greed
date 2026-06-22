extends Control

func _process(_delta: float) -> void:
	$indicator/count.text = str(CalorieManager.calories)
	$indicator.position.x = CalorieManager.calories / 10 
