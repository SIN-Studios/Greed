extends CharacterBody2D

var current_enemy: enemy = load("res://Enemies/apple.tres")
var health: int

func _ready() -> void:
	if !current_enemy:
		return
	$AnimatedSprite2D.sprite_frames = current_enemy.texture
	health = current_enemy.health
