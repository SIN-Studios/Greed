extends Node2D

var sleeping: bool = false
var bedtime: int
var sleeptime: int
var waketime: int
var sleep_defecit: int 
var laying: bool = false
var can_sleep: bool
var after_20: bool
var before_08: bool
var slept: bool = true
var nights_missed: int

func _ready() -> void:
	Global.bed = self

#trigered whenever the item on the ground is interacted with
func interacted_with():
	if laying:
		# allows player to leave bed before the fall asleep
		SignalManager.player_get_up.emit()
		TimeManager.timescale = 120
		return

	#if its after 8:00pm (night time)
	SignalManager.player_lay_down.emit()
	@warning_ignore("integer_division")
	#waits 15-30 in game minutes for player to fall asleep
	await get_tree().create_timer(randi_range(900, 1800) / TimeManager.timescale).timeout
	#makes sure the player hasn't gotten up before putting them to sleep
	if not laying:
		return
	sleeping = true
	TimeManager.timescale = 3000
	#gets the time the player fell asleep
	bedtime = snapped(TimeManager.day_time, 1800)
	#decides when player will wake up
	waketime = bedtime + 32400
	if waketime > 86400:
		waketime -= 86400
		sleep_defecit = 0
	if waketime > 28800:
		sleep_defecit = waketime - 28800
		waketime = 28800
	@warning_ignore("narrowing_conversion")
	waketime = waketime * randf_range(0.98, 1.02)

#triggered every frame
func _process(_delta: float) -> void:
	laying = (Global.player.player_state_machine.current_state.name.to_lower() == "playerlaystate")
	after_20 = TimeManager.day_time > 72000
	before_08 = TimeManager.day_time < 28800
	if after_20:
		slept = false
	elif not before_08 and not slept:
		nights_missed += 1
		slept = true
	if nights_missed == 1:
		Global.player.speed_multiplier3 = 0.80
	elif nights_missed == 2:
		Global.player.speed_multiplier3 = 0.40
	elif nights_missed == 3:
		Global.player.speed_multiplier3 = 0.20
	elif nights_missed > 3:
		SignalManager.player_dies.emit()
	
	#checks if the players inventory is full
	#checks to see if the player should be woken up
	if sleeping and TimeManager.day_time >= waketime and before_08:
		#wakes the player up
		sleeping = false
		slept = true
		if sleep_defecit > 0:
			Global.player.speed_multiplier3 = max(1.0 - (sleep_defecit / 60.0 * 0.01), 0.5)
		else:
			Global.player.speed_multiplier3 = 1.0
		SignalManager.player_get_up.emit()
		TimeManager.timescale = 120
	
	
	if sleeping:
		$Sprite2D.texture = preload("res://Seth designs/bedwplayer.png")
		$interaction/Label.text = ""
		$interaction.can_interact = false
	elif laying:
		$Sprite2D.texture = preload("res://Seth designs/bedwplayer.png")
		$interaction/Label.text = "Hold E to get up"
		$interaction.can_interact = true
	elif not after_20 and not before_08 or (slept and before_08):
		$Sprite2D.texture = preload("res://Seth designs/bed.png")
		$interaction/Label.text = "Can't sleep: too early"
		$interaction.can_interact = false
	else:
		$Sprite2D.texture = preload("res://Seth designs/bed.png")
		$interaction/Label.text = "Hold E to lie down"
		$interaction.can_interact = true
