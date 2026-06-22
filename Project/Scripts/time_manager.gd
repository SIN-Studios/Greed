extends Node

var military_hours: int
var full_time: float
var round_time: int

var days: int
var hours: int
var minutes: int
var am_pm: String = "AM"

const timescale = 144 # 10 irl minutes

func _process(delta: float) -> void:
	full_time += timescale * delta
	round_time = int(floor(full_time))
	military_hours = round_time / 3600
	hours = military_hours % 12
	if hours == 0:
		hours = 12
	if military_hours == 12:
		am_pm = "PM"
	elif military_hours == 24:
		military_hours = 0
		am_pm = "AM"
		days += 1
	minutes = (round_time % 3600) / 60
