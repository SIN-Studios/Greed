extends State

class_name PlayerDiesState

func _ready() -> void:
	SignalManager.player_dies.connect(player_dies)

func player_dies():
	state_machine.change_state("playerdiesstate")

func enter():
	print("player died")
	SignalManager.emit_signal("game_over")
