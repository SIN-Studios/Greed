extends Node2D

var sleeping: bool = false
var bedtime: int
var sleeptime: int
var waketime: int
var sleep_defecit: int 
var laying: bool = false
var can_sleep: bool
var after_8: bool

#trigered whenever the item on the ground is interacted with
func interacted_with():
	if laying:
		# allows player to leave bed before the fall asleep
		laying = false
		SignalManager.player_get_up.emit()
		return
	#if its after 8:00pm (night time)
	if after_8:
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
	after_8 = TimeManager.day_time > 72000
	#checks if the players inventory is full
	#checks to see if the player should be woken up
	if sleeping and TimeManager.day_time >= waketime and not after_8:
		#wakes the player up
		sleeping = false
		SignalManager.player_get_up.emit()

	if sleeping:
		$interaction/Label.text = "Can't sleep: already asleep"
		$interaction.can_interact = false
	elif laying:
		$interaction/Label.text = "Hold E to get up"
		$interaction.can_interact = true
	elif not after_8:
		$interaction/Label.text = "Can't sleep: too early"
		$interaction.can_interact = false
	else:
		$interaction/Label.text = "Hold E to lie down"
		$interaction.can_interact = true
