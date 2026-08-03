extends State

class_name EnemyDiesState

func enter():
	if !control:
		return
	control.queue_free()
