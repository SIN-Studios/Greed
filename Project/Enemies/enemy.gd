extends CharacterBody2D

var enemy_array: Array = [preload("res://Enemies/Enemy Resources/bao_bun.tres")]
var current_enemy: enemy = enemy_array.pick_random()
var health: int
var base_damage: int
var roam_speed: int
var chase_speed: int

func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = current_enemy.texture
	health = current_enemy.health
	base_damage = current_enemy.base_damage
	roam_speed = current_enemy.roam_speed
	chase_speed = current_enemy.chase_speed
