#This script is 100% copied of the internet and is one of the only scripts I don't know how works

extends Node

class_name PlayerStateMachine

@export var initial_state: PlayerState
var current_state: PlayerState
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child
			child.player_state_machine = self
	
	if initial_state:
		change_state(initial_state.name.to_lower())

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())

	if current_state:
		current_state.enter()
