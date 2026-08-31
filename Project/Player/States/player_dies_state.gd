extends State

class_name PlayerDiesState

func enter():
	print("player died")
	SignalManager.emit_signal("game_over")
