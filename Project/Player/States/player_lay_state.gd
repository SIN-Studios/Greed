extends State

class_name PlayerLayState

var wake_up_position: Vector2

func _ready() -> void:
	SignalManager.player_lay_down.connect(lay_down_signal)
	SignalManager.player_get_up.connect(get_up_signal)

func lay_down_signal():
	state_machine.change_state("playerlaystate")

func get_up_signal():
	state_machine.change_state("playeridlestate")

func enter():
	print("lay_down")
	control.set_physics_process(false)
	wake_up_position = Global.bed.global_position + Vector2(25,0)
	control.global_position = Global.bed.global_position
	control.rotation = Global.bed.rotation
	control.visible = false

func exit():
	print("get_up")
	control.global_position = wake_up_position
	control.rotation = 0
	control.visible = true
