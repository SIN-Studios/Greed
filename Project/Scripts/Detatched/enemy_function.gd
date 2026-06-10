extends Node
class_name enemy_function 


static func idleing(enemy):
	enemy.velocity = Vector2.ZERO

static func following(enemy, player):
	var direction = enemy.global_position.direction_to(player.global_position)
	enemy.velocity = direction * enemy.speed * enemy.speed_multuplier
	if enemy.speed_multuplier != 1:
		enemy.speed_multuplier += 1
	else:
		enemy.set_collision_mask_value(4, true)

static func attacking(enemy):
	var new_damage = enemy.base_damage * randf_range(0.8, 1.2)
	SignalManager.player_take_damage.emit(new_damage)

static func skittering(_enemy):
	pass

static func hurting(enemy, damage):
	print("enemy ", enemy.health)
	enemy.health -= damage
	if enemy.health <= 0:
		summon_item(enemy)
		enemy.queue_free()
	#knockback enemy
	enemy.speed_multuplier = -10
	enemy.set_collision_mask_value(4, false)

static func charging(_enemy):
	pass
	
static func summon_item(enemy) -> void:
	var new_item = enemy.item.instantiate()
	new_item.global_position = enemy.global_position
	new_item.name = "item_1"
	enemy.call_deferred("add_sibling", new_item, true)
