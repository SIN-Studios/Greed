extends State

class_name PlayerLayState

var wake_up_position: Vector2
var bed: Node2D

func _ready() -> void:
	SignalManager.player_lay_down.connect(lay_down_signal)
	SignalManager.player_get_up.connect(get_up_signal)

func lay_down_signal(bed_node):
	bed = bed_node
	state_machine.change_state("playerlaystate")

func get_up_signal():
	state_machine.change_state("playeridlestate")

func enter():
	control.set_physics_process(false)
	wake_up_position = control.global_position
	control.global_position = bed.global_position
	control.rotation = bed.rotation
	$"../../knife".visible = false

func exit():
	control.global_position = wake_up_position
	control.rotation = 0
	$"../../knife".visible = true
