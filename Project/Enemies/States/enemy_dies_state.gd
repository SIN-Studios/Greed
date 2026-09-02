extends State

class_name EnemyDiesState

@onready var item_scene = preload("res://Assets/item.tscn")
@onready var death = preload("res://Sound/sfx/enemy death.mp3")

func enter():
	if control.name == "apple_1":
		SignalManager.first_enemy_killed.emit()
	var particles = control.get_node_or_null("CPUParticles2D")
	if particles:
		particles.reparent(control.get_parent())
		particles.emitting = true
		get_tree().create_timer(particles.lifetime).timeout.connect(particles.queue_free)
	if not state_machine.last_state is EnemyExplodeState:
		drop_item()
	#else:
		#AudioManager.play_sfx(explode, true)
	control.queue_free()

func drop_item():
	Global.enemies_killed += 1
	AudioManager.play_sfx(death, true)
	var dropped_item = item_scene.instantiate()
	dropped_item.item = control.current_enemy
	dropped_item.global_position = control.global_position
	control.get_parent().add_child.call_deferred(dropped_item)
