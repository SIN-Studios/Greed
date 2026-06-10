extends Node2D


func _on_timer_timeout() -> void:
	get_parent().queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$Timer.start()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$Timer.stop()
