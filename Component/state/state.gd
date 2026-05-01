class_name State extends Node

signal state_next(nextState: State)

@export var state_owner: Node:
	set(value):
		state_owner = value
		_validate_owner()

func _validate_owner(): pass

func state_call(delta: float) -> void:
	print("Unimplemented State Called")
	return
