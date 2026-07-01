extends Node2D

func interacted_with():
	print("yay")
	SignalManager.player_go_to_sleep.emit(self)
