extends Node
class_name enemy_function 


static func idleing(enemy):
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, enemy.slipperiness_factor)
	enemy.velocity.y = move_toward(enemy.velocity.y, 0, enemy.slipperiness_factor)

static func following(enemy, player):
	var direction = enemy.global_position.direction_to(player.global_position)
	enemy.velocity = direction * enemy.speed * enemy.speed_multuplier
	if enemy.speed_multuplier != 1:
		if enemy.speed_multuplier <= 1:
			enemy.speed_multuplier += 1
		elif enemy.speed_multuplier >= 1:
			enemy.speed_multuplier -= 1
		else:
			enemy.speed_multuplier = 1
	else:
		enemy.set_collision_mask_value(4, true)

static func attacking(enemy):
	var new_damage = enemy.base_damage * randf_range(0.8, 1.2)
	SignalManager.player_take_damage.emit(new_damage)

static func skittering(enemy, player):
	var direction = enemy.global_position.direction_to(player.global_position)
	enemy.velocity = direction * enemy.speed

static func hurting(enemy, damage, player):
	enemy.velocity = Vector2.ZERO
	print("enemy ", enemy.health)
	enemy.health -= damage
	if enemy.health <= 0:
		summon_item(enemy)
		enemy.queue_free()
	#knockback enemy
	enemy.speed_multuplier = -10
	enemy.set_collision_mask_value(4, false)
	for i in range(-10,0):
		var direction = enemy.global_position.direction_to(player.global_position)
		enemy.velocity = direction * (enemy.speed / 5) * i
	enemy.set_collision_mask_value(4, true)

static func charging(enemy, player):
	for i in 180:
		if is_instance_valid(enemy):
			await enemy.get_tree().create_timer(0.01).timeout
			if is_instance_valid(enemy):
				enemy.rotation += 1
	if is_instance_valid(enemy):
		enemy.rotation = 0
		var direction = enemy.global_position.direction_to(player.global_position)
		rolling(enemy, player, direction)

static func rolling(enemy, player, direction):
	enemy.velocity = direction * enemy.speed

static func waiting():
	pass

static func summon_item(enemy) -> void:
	var new_item = enemy.item.instantiate()
	new_item.global_position = enemy.global_position
	new_item.name = "item_1"
	enemy.call_deferred("add_sibling", new_item, true)
