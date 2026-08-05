extends State

class_name EnemyAttackState

func enter():
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("attack"):
		control.get_node("AnimatedSprite2D").play("attack")
		await control.get_node("AnimatedSprite2D").animation_finished
	elif control.get_node("AnimatedSprite2D").sprite_frames.has_animation("default"):
		control.get_node("AnimatedSprite2D").play("default")

	SignalManager.player_take_damage.emit(15, (control.position.direction_to(Global.player.position)))
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("recoil"):
		control.get_node("AnimatedSprite2D").play("recoil")
		await control.get_node("AnimatedSprite2D").animation_finished
	state_machine.change_state("enemychasestate")
