extends State

class_name EnemyExplodeState

var in_damage_range: bool = false
@onready var death = preload("res://Sound/sfx/enemy death.mp3")

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		state_machine.change_state("enemyexplodestate")


func enter():
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("explode"):
		AudioManager.play_sfx(death, true)
		control.get_node("AnimatedSprite2D").play("explode")

	if in_damage_range:
		var hit_direction = control.position.direction_to(Global.player.position)
		var damage: int = control.base_damage * randf_range(0.8,1.2)
		if Global.player.get_node("StateMachine/PlayerHurtState").has_method("take_damage"):
			Global.player.get_node("StateMachine/PlayerHurtState").take_damage(damage, hit_direction * 1200)

	await control.get_node("AnimatedSprite2D").animation_finished

	state_machine.change_state("enemydiesstate")

func _on_damage_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_damage_range = true



func _on_damage_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_damage_range = false
