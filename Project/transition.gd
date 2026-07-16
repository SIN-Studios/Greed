extends CanvasLayer


var _target_scene: String = ""
@onready var wipe = $ColorRect

func slide_and_change_scene(scene_path: String):
	_target_scene = scene_path
	wipe.visible = true
	
	wipe.position.y = -wipe.size.y

	var tween = create_tween()
	tween.tween_property(wipe, "position:y", 0, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_callback(Callable(self, "change_scene"))
	tween.tween_interval(0.2)
	tween.tween_property(wipe, "position:y", wipe.size.x, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(Callable(self, "queue_free"))

func change_scene():
	if _target_scene != "":
		get_tree().change_scene_to_file.call_deferred(_target_scene)
