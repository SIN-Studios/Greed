extends Node2D

@onready var weapon: Node2D = $knife/Area2D/CollisionShape2D
const weapon_damage: int = 20

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("ui_accept"):
		weapon.disabled = false
	elif weapon.disabled == false:
		weapon.disabled = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("step1")
		@warning_ignore("narrowing_conversion")
		var new_damage: int = weapon_damage * randf_range(0.8,1.2)
		SignalManager.enemy_take_damage.emit(new_damage)
