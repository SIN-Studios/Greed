extends State

class_name EnemyChaseState

const speed: int = 50

func enter():
	if !control:
		return

func physics_update(_delta):
	control.velocity = control.position.direction_to(Global.player.position) * speed
	
	control.move_and_slide()

func _on_detection_range_exit_body_exited(body: Node2D) -> void:
	if body != Global.player:
		return
	state_machine.change_state("enemyroamstate")


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body != Global.player:
		return
	state_machine.change_state("enemyattackstate")
