extends Node2D

@onready var weapon: Node2D = $Area2D
@onready var weapon_screen_pos = weapon.get_global_transform_with_canvas().origin
@onready var screen_center = get_viewport().get_visible_rect().size / 2.0
@onready var ring_radius = screen_center.distance_to(weapon_screen_pos)


var mouse_velocity : Vector2 = Vector2.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		mouse_velocity = event.velocity 

func _process(_delta):
	lock_mouse_to_ring()
	look_at(get_global_mouse_position())

func lock_mouse_to_ring():
	# 1. Convert player's world position to Viewport (Screen) position
	var player_screen_pos = get_global_transform_with_canvas().origin
	
	# 2. Get current mouse position in Viewport space
	var mouse_screen_pos = get_viewport().get_mouse_position()
	
	# 3. Get direction vector from player to mouse
	var dir = (mouse_screen_pos - player_screen_pos).normalized()
	
	# Fallback if mouse is directly on top of the player center
	if dir == Vector2.ZERO:
		dir = Vector2.RIGHT
	
	# 4. Calculate target position on the ring
	var target_screen_pos = player_screen_pos + (dir * ring_radius)
	
	# 5. Warp mouse only if it's off the ring (prevents unnecessary warping)
	if mouse_screen_pos.distance_to(target_screen_pos) > 1.0:
		get_viewport().warp_mouse(target_screen_pos)
