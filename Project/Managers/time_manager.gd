extends Node

var military_hours: int
var full_time: float = 43200
var round_time: int
var day_time: int

var days: int
var hours: int
var minutes: int
var am_pm: String = "AM"
var am_pm_just_changed: bool = false

var timescale = 120 # 12 irl minutes per day (1440/time for day = timescale)

func _ready() -> void:
	SignalManager.change_timescale.connect(change_timescale)

func _process(delta: float) -> void:
	@warning_ignore_start("integer_division")
	full_time += timescale * delta
	round_time = int(floor(full_time))
	day_time = round_time % 86400
	military_hours = round_time / 3600
	hours = military_hours % 12
	if hours == 0:
		hours = 12
	if am_pm_just_changed:
		if  not ((43100 < day_time and day_time < 43300) or (86300 < day_time and day_time < 86500)):
			am_pm_just_changed = false
	elif 43100 < day_time and day_time < 43300:
		am_pm_just_changed = true
		am_pm = "PM"
	elif 86300 < day_time and day_time < 86500:
		am_pm_just_changed = true
		military_hours = 0
		am_pm = "AM"
		days += 1
		SignalManager.new_day.emit()
	
	minutes = (round_time % 3600) / 60

func change_timescale(amount):
	timescale += amount
