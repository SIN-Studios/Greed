extends CharacterBody2D

var enemy_array: Array = [preload("res://Enemies/Enemy Resources/apple.tres"), preload("res://Enemies/Enemy Resources/bao_bun.tres"), preload("res://Enemies/Enemy Resources/drumstick.tres"), preload("res://Enemies/Enemy Resources/sushi.tres")]
var current_enemy: enemy = enemy_array.pick_random()
var health: int

func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = current_enemy.texture
	health = current_enemy.health
