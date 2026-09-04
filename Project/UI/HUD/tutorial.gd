extends Control

var stage: float = -1.0
var left_base: bool = false
var understand_eating: bool = false
var understand_base: bool = false

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	Global.bed.get_node("interaction").visible = false
	Global.bed.process_mode = Node.PROCESS_MODE_DISABLED

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and stage >= 0 and stage <= 3:
		print('skip')
		$AnimationPlayer.play("SKIP")
		stage = 3.5
		$skip.visible = false
		get_tree().paused = false
		$skip/skip_timer.start()
	if event.is_action_pressed("ui_text_backspace"):
		$AnimationPlayer.play("SKIP")
		stage = 7.0
		get_tree().paused = false
		$skip.visible = false
		Global.bed.get_node("interaction").visible = true
		Global.bed.process_mode = Node.PROCESS_MODE_INHERIT
		Global.player.player_state_machine.change_state("playeridlestate")
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		$skip/skip_timer.stop()
	if event.is_pressed() and not event.is_echo():
		if $AnimationPlayer.is_playing() or stage >= 5.0:
			return
		$skip.visible = false
		$skip/skip_timer.start(4.0)
		stage += 1.0
		if stage == 4.0:
			stage = 3.5
		elif stage == 4.5:
			stage = 4.0
		if stage == 3.5:
			get_tree().paused = false
		elif stage == 5.0:
			Global.bed.process_mode = Node.PROCESS_MODE_INHERIT
			Global.player.player_state_machine.change_state("playeridlestate")
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
			$movement/movement_timer.start()
		$AnimationPlayer.play(str(stage))
		if stage == 5.0:
			Global.bed.get_node("interaction").visible = true
			$skip.visible = false
			await SignalManager.first_enemy_killed
			$using_the_weapon.visible = false
			stage = 6.0
			$AnimationPlayer.play(str(stage))
			var old_calories = 10000
			while old_calories > CalorieManager.calories:
				old_calories = CalorieManager.calories
				await SignalManager.player_update_calories
			$hunger_bar.visible = false
			understand_eating = true

func _process(_delta: float) -> void:
	if not Global.in_base and not left_base:
		left_base = true
		$using_the_weapon/weapon_timer.start()



	if stage == 5.0 and Global.player.health <= 150 and left_base:
		$using_the_weapon.visible = true

	if stage == 6.0 and CalorieManager.calories <= 1500 and not $base.visible and not understand_eating:
		$hunger_bar.visible = true

	if stage == 6.0 and Global.player.health <= 100 and not Global.in_base:
		$base.visible = true
		$hunger_bar.visible = false

	if stage == 6.0 and TimeManager.day_time >= 79200 and not Global.player.player_state_machine.current_state.name.to_lower() == "playerlaystate":
		$sleep.visible = true
		$hunger_bar.visible = false
		$base.visible = false
	elif TimeManager.day_time > 79200:
		stage = 7.0



	if Global.player.player_state_machine.current_state.name.to_lower() == "playerwalkstate" and $movement.visible:
		$movement.visible = false
		$movement/movement_timer.start()
	
	if stage == 6.0 and (Global.player.health > 150 or Global.in_base) and $base.visible and not understand_base:
		$base.visible = false
		understand_base = true
	
	if Global.player.player_state_machine.current_state.name.to_lower() == "playerlaystate" and $sleep.visible:
		$sleep.visible = false



func _on_skip_timer_timeout() -> void:
	if stage == -1:
		$skip.text = "Press any key to start"
	elif stage <= 3:
		$skip.text = "Press any key to continue or E to skip cutscene"
	else:
		$skip.text = "Press any key to continue"
	if stage < 5.0:
		$skip.visible = true
	else:
		$skip.visible = false
		$skip/skip_timer.stop()


func _on_movement_timer_timeout() -> void:
	if stage == 5.0 and not left_base:
		$movement.visible = true
	else:
		$movement.visible = false
		$movement/movement_timer.stop()


func _on_weapon_timer_timeout() -> void:
	if stage == 5.0 and left_base:
		$using_the_weapon.visible = true
	else:
		$using_the_weapon.visible = false
		$using_the_weapon/weapon_timer.stop()
