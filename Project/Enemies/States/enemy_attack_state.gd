extends State

class_name EnemyAttackState

func enter():
	if !control:
		return
	SignalManager.player_take_damage.emit(15, (control.position.direction_to(Global.player.position)))
	state_machine.change_state("enemychasestate")
