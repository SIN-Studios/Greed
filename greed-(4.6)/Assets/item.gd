extends Node2D

func interacted_with():
	SignalManager.player_picks_up_item.emit()
	queue_free()
