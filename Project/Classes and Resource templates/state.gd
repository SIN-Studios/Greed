extends Node

class_name State

var state_machine: StateMachine
@onready var control = get_parent().get_parent()

func enter():
	pass

func exit():
	pass

func update(_delta: float) :
	pass

func physics_update(_delta: float):
	pass

func handle_input(_event: InputEvent) :
	pass
