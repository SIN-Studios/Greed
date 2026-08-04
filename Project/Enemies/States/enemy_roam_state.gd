extends State

class_name EnemyRoamState

const speed: int = 10
var direction: Vector2 = Vector2.ZERO
@onready var timer = $"../../Timer"

func enter():
	if is_inside_tree():
		await get_tree().create_timer(0.01).timeout
	if control.get_node("AnimatedSprite2D").sprite_frames.has_animation("roam"):
		control.get_node("AnimatedSprite2D").play("roam") 
	timer.start.call_deferred()


func exit():
	timer.stop()


func _on_timer_timeout() -> void:
	timer.wait_time = choose([1,1.5,2])
	direction = choose([Vector2.ZERO, Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT])

func physics_update(delta):
	control.velocity += direction * speed * delta
	
	control.move_and_slide()

func choose(array):
	array.shuffle()
	return array.front()

func _on_detection_range_enter_body_entered(body: Node2D) -> void:
	if body != Global.player:
		return
	state_machine.change_state("enemychasestate")
