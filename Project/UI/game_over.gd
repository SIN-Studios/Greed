extends Control

var tween 

func _ready() -> void:
	SignalManager.game_over.connect(open)
	close()


func open():
	var days_survived: String
	var enemies_killed: String
	var calories_eatan: String
	if TimeManager.days == 1:
		days_survived = "you survived " + str(1) + " day"
	else:
		days_survived = "you survived " + str(TimeManager.days) + " days"
	enemies_killed = "you killed " + str(Global.enemies_killed) + " enemies"
	calories_eatan = "you ate " + str(CalorieManager.all_time_calories) + " calories"
	$VBoxContainer/Label2.text = days_survived + "\n" + enemies_killed + "\n" + calories_eatan
	print("recieved signal")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.visible = true
	$"../../HUD".visible = false

func close():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.hide()
	$"../../HUD".visible = true

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	CalorieManager.calories = 2250
	TimeManager.full_time = 43200
	Global.player.player_inventory = load("res://Inventory/players_inventory.tres")
	close()

func _on_quit_pressed() -> void:
	if OS.get_name() == "Web":
		print("Quit button does not work on web.")
		$VBoxContainer/quit.visible = false
		return
	get_tree().quit()
