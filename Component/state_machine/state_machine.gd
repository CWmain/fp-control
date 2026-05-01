class_name State_Machine extends Node

@export var state_owner: Node
@export var current_state: State

func _ready() -> void:
	# Assign the owner node to all child states
	for state in get_children():
		state.state_owner = state_owner
	
	# Connect the next state signal for current state
	current_state.state_next.connect(_on_state_next)

func state_call(delta: float) -> void:
	current_state.state_call(delta)

func _on_state_next(next_state: State):
	print("Swapping from %s to %s" % [current_state.name, next_state.name])
	# When current state is updated, disconnect and connect the new state_next signal
	current_state.state_next.disconnect(_on_state_next)
	next_state.state_next.connect(_on_state_next)
	current_state = next_state
