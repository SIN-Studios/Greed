extends Node2D

var sleeping: bool = false
var bedtime: int
var sleeptime: int
var waketime: int
var sleep_defecit: int 
var laying: bool = false

#trigered whenever the item on the ground is interacted with
func interacted_with():
	if laying:
		# allows player to leave bed before the fall asleep
		laying = false
		SignalManager.player_get_up.emit()
		return
	#if its after 8:00pm (night time)
	if TimeManager.day_time > 72000:
		SignalManager.player_lay_down.emit(self)
		laying = true
		@warning_ignore("integer_division")
		#waits 15-30 in game minutes for player to fall asleep
		await get_tree().create_timer(randi_range(900, 1800) / TimeManager.timescale).timeout
		#makes sure the player hasn't gotten up before putting them to sleep
		if not laying:
			return
		#maybe this will be replaced by a proper statemachine 
		#otherwise for now changes the players 'state' from laying to sleeping
		laying = false
		sleeping = true
		SignalManager.player_go_to_sleep.emit()
		#gets the time the player fell asleep
		bedtime = snapped(TimeManager.day_time, 1800)
		#decides when player will wake up
		waketime = bedtime + 32400
		if waketime > 86400:
			waketime -= 86400
		if waketime > 28800:
			sleep_defecit = waketime - 28800
			waketime = 28800
		@warning_ignore("narrowing_conversion")
		waketime = waketime * randf_range(0.98, 1.02)

#triggered every tick
func _process(_delta: float) -> void:
	#checks to see if the player should be woken up
	if sleeping and TimeManager.day_time >= waketime and TimeManager.day_time < 72000 :
		#wakes the player up
		sleeping = false
		SignalManager.player_get_up.emit()
