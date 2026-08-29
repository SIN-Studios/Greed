extends CharacterBody2D

@onready var enemy_path: String = "res://Enemies/Enemy Resources/" + self.name + ".tres"
var current_enemy: enemy
var health: int
var base_damage: int
var roam_speed: int
var chase_speed: int

var facing_right: bool = true

func _ready() -> void:
	if self.name.begins_with("enemy"):
		return
	current_enemy = load(enemy_path)
	$AnimatedSprite2D.sprite_frames = current_enemy.texture
	health = current_enemy.health
	base_damage = current_enemy.base_damage
	roam_speed = current_enemy.roam_speed
	chase_speed = current_enemy.chase_speed
