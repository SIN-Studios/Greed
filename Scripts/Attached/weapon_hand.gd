extends Node2D

@onready var weapon: Node2D = $knife/Area2D/CollisionShape2D
const weapon_damage: int = 20

func _ready() -> void:
	weapon.disabled = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		weapon.set_deferred("disabled", false)
	elif weapon.disabled == false:
		await get_tree().create_timer(0.1).timeout
		weapon.set_deferred("disabled", true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		@warning_ignore("narrowing_conversion")
		var new_damage: int = weapon_damage * randf_range(0.8,1.2)
		SignalManager.enemy_take_damage.emit(new_damage, body)
