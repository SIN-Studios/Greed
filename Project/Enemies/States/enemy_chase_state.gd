extends State

class_name EnemyChaseState

const speed: int = 75

func enter():
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("chase"):
		control.get_node("AnimatedSprite2D").play("chase")
	elif control.get_node("AnimatedSprite2D").sprite_frames.has_animation("default"):
		control.get_node("AnimatedSprite2D").play("default")

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
