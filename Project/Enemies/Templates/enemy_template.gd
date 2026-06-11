extends CharacterBody2D

enum states {idleing, following, attacking, hurting, charging}
var state: states = states.idleing
var previous_state: states
var player: CharacterBody2D

const speed: int = 100
var speed_multuplier: int = 1
const base_damage: int = 10
var health: int = 100

var enemy_hurt_damage

var item: PackedScene = preload("res://Scenes/Spawnable/item.tscn")

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	SignalManager.enemy_take_damage.connect(take_damage)

func _process(_delta: float) -> void:
	if state == states.idleing:
		enemy_function.idleing(self)
	elif state == states.following:
		enemy_function.following(self, player)
	elif state == states.attacking:
		enemy_function.attacking(self)
		state = previous_state
	elif state == states.hurting:
		enemy_function.hurting(self, enemy_hurt_damage)
		state = previous_state
	elif state == states.charging:
		enemy_function.charging(self)

func change_state(new_state: states):
	previous_state = state
	state = new_state

func _physics_process(_delta: float) -> void:
	move_and_slide()

#attack player
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		change_state(states.attacking)

#take damage
func take_damage(damage, body) -> void:
	if body == self:
		enemy_hurt_damage = damage
		change_state(states.hurting)

#chase player
func _on_detection_range_body_entered(body: Node2D) -> void:
	if body == player:
		change_state(states.following)

#idle when player not around
func _on_focus_range_body_exited(body: Node2D) -> void:
	if body == player:
		change_state(states.idleing)
