extends Control

var display_time: String

func _process(_delta: float) -> void:
	display_time = "%02d:%02d %s" % [TimeManager.hours, TimeManager.minutes, TimeManager.am_pm]
	$Label.text = display_time
