extends Control

var display_time: String

#triggered every tick 
func _process(_delta: float) -> void:
	#properly formats display_time
	display_time = "%02d:%02d %s" % [TimeManager.hours, TimeManager.minutes, TimeManager.am_pm]
	#changes the clock label to display_time
	$Label.text = display_time
