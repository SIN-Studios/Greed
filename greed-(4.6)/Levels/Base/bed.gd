extends Node2D

var sleeping: bool = false
var bedtime: int
var sleeptime: int
var waketime: int
var sleep_defecit: int 
var laying: bool = false

func interacted_with():
	if laying:
		laying = false
		SignalManager.player_get_up.emit()
		return
	if TimeManager.day_time > 72000:
		SignalManager.player_lay_down.emit(self)
		laying = true
		@warning_ignore("integer_division")
		await get_tree().create_timer(1800 / TimeManager.timescale).timeout
		if not laying:
			return
		laying = false
		sleeping = true
		SignalManager.player_go_to_sleep.emit()
		bedtime = snapped(TimeManager.day_time, 1800)
		waketime = bedtime + 32400
		if waketime > 86400:
			waketime -= 86400
		if waketime > 28800:
			sleep_defecit = waketime - 28800
			waketime = 28800
		@warning_ignore("narrowing_conversion")
		waketime = waketime * randf_range(0.98, 1.02)

func _process(_delta: float) -> void:
	if sleeping and TimeManager.day_time >= waketime and TimeManager.day_time < 72000 :
		sleeping = false
		SignalManager.player_get_up.emit()
