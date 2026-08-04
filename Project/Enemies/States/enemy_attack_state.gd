extends State

class_name EnemyAttackState

func enter():
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("attack"):
		control.get_node("AnimatedSprite2D").play("attack")
	SignalManager.player_take_damage.emit(15, (control.position.direction_to(Global.player.position)))
	state_machine.change_state("enemychasestate")
