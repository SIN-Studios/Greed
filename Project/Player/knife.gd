#lock_mouse() and flip_sprite() where created in part by Gemini
extends Node2D

@onready var weapon: Node2D = $Area2D

var max_knockback_force: float = 500.0
var base_damage: int = 10

var mouse_velocity: Vector2 = Vector2.ZERO
var last_position: Vector2 = Vector2.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta):
	lock_mouse()
	look_at(get_global_mouse_position())
	flip_sprite()

func _physics_process(delta):
	var current_mouse_pos = get_global_mouse_position()
	mouse_velocity = (current_mouse_pos - last_position) / delta
	last_position = current_mouse_pos

func lock_mouse():
	var player_screen_pos = Global.player.get_global_transform_with_canvas().origin
	var weapon_screen_pos = weapon.get_global_transform_with_canvas().origin
	var ring_radius = player_screen_pos.distance_to(weapon_screen_pos)
	var mouse_screen_pos = get_viewport().get_mouse_position()
	var dir = (mouse_screen_pos - player_screen_pos).normalized()
	var target_screen_pos = player_screen_pos + (dir * ring_radius)

	if mouse_screen_pos.distance_to(target_screen_pos) > 1.0:
		get_viewport().warp_mouse(target_screen_pos)

func flip_sprite():
	var player_screen_pos = Global.player.get_global_transform_with_canvas().origin
	var mouse_screen_pos = get_viewport().get_mouse_position()
	var dir = (mouse_screen_pos - player_screen_pos).normalized()
	var angular_motion = dir.cross(mouse_velocity)
	if angular_motion > 50.0:
		$Sprite2D.flip_h = false
	elif angular_motion < -50.0:
		$Sprite2D.flip_h = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var speed = mouse_velocity.length()
		if speed > 500.0:
			var hit_direction = mouse_velocity.normalized() * -1 + (body.global_position - Global.player.global_position).normalized()
			var damage: int = base_damage * (speed / 750) * randf_range(0.8,1.2)
			var knockback_strength = min(speed * 2.0, max_knockback_force)
	
			if body.get_node("StateMachine/EnemyDamageState").has_method("take_damage"):
				body.get_node("StateMachine/EnemyDamageState").take_damage(damage, hit_direction * knockback_strength)
