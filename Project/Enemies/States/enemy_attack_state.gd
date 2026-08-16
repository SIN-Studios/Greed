extends State

class_name EnemyAttackState


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		state_machine.change_state("enemyattackstate")


func enter():
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("attack"):
		control.get_node("AnimatedSprite2D").play("attack")
		await control.get_node("AnimatedSprite2D").animation_finished
	elif control.get_node("AnimatedSprite2D").sprite_frames.has_animation("default"):
		control.get_node("AnimatedSprite2D").play("default")

	var hit_direction = control.position.direction_to(Global.player.position)
	var damage: int = control.base_damage * randf_range(0.8,1.2)
	if Global.player.get_node("StateMachine/PlayerHurtState").has_method("take_damage"):
		Global.player.get_node("StateMachine/PlayerHurtState").take_damage(damage, hit_direction * 300)

	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("recoil"):
		control.get_node("AnimatedSprite2D").play("recoil")
		await control.get_node("AnimatedSprite2D").animation_finished
	state_machine.change_state("enemychasestate")
