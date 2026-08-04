extends CharacterBody2D

var enemy_array: Array = [preload("res://Enemies/apple.tres")]
var current_enemy: enemy = enemy_array.pick_random()
var health: int

func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = current_enemy.texture
	health = current_enemy.health
