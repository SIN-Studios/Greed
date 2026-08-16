extends State

class_name PlayerDiesState

func enter():
	print("player died")
	get_tree().quit()
