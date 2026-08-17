extends Control

var tween 

func _ready() -> void:
	await get_tree().process_frame
	$PanelContainer/Node/VBoxContainer/resume.pivot_offset = $PanelContainer/Node/VBoxContainer/resume.size / 2
	$PanelContainer/Node/VBoxContainer/settings.pivot_offset = $PanelContainer/Node/VBoxContainer/settings.size / 2
	$PanelContainer/Node/VBoxContainer/quit.pivot_offset = $PanelContainer/Node/VBoxContainer/quit.size / 2
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu") and get_tree().paused == false:
		get_tree().paused = true
		$AnimationPlayer.play("blur")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("menu") and get_tree().paused == true:
		get_tree().paused = false
		$AnimationPlayer.play_backwards("blur")
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_resume_pressed() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($PanelContainer/Node/VBoxContainer/resume, "scale", Vector2(0,0), 0.1).from_current()
	$AnimationPlayer.play_backwards("blur")
	await tween.finished
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false

func _on_settings_pressed() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($PanelContainer/Node/VBoxContainer/settings, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	print("Settings not set up")

func _on_quit_pressed() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property($PanelContainer/Node/VBoxContainer/quit, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	get_tree().quit()
	if OS.get_name() == "Web":
		print("Quit button does not work on web.")


func _on_resume_mouse_entered() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($PanelContainer/Node/VBoxContainer/resume, "scale", Vector2(1.25,1.25), 0.1).from_current()
	$PanelContainer/Node/VBoxContainer/resume.use_parent_material = true

func _on_resume_mouse_exited() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($PanelContainer/Node/VBoxContainer/resume, "scale", Vector2(1,1), 0.1).from_current()
	$PanelContainer/Node/VBoxContainer/resume.use_parent_material = false

func _on_settings_mouse_entered() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($PanelContainer/Node/VBoxContainer/settings, "scale", Vector2(1.25,1.25), 0.1).from_current()
	$PanelContainer/Node/VBoxContainer/settings.use_parent_material = true

func _on_settings_mouse_exited() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($PanelContainer/Node/VBoxContainer/settings, "scale", Vector2(1,1), 0.1).from_current()
	$PanelContainer/Node/VBoxContainer/settings.use_parent_material = false

func _on_quit_mouse_entered() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($PanelContainer/Node/VBoxContainer/quit, "scale", Vector2(1.25,1.25), 0.1).from_current()
	$PanelContainer/Node/VBoxContainer/quit.use_parent_material = true

func _on_quit_mouse_exited() -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($PanelContainer/Node/VBoxContainer/quit, "scale", Vector2(1,1), 0.1).from_current()
	$PanelContainer/Node/VBoxContainer/quit.use_parent_material = false
