class_name State_Machine extends Node

@export var state_owner: Node
@export var current_state: State

func _ready() -> void:
	# Assign the owner node to all child states
	for state in get_children():
		state.state_owner = state_owner


func state_call(delta: float) -> void:
	current_state.state_call(delta)
