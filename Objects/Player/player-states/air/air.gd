extends State

@export var grounded_state: State

func _validate_owner():
	assert(state_owner is CharacterBody3D, "%s: state_owner must be a CharacterBody3D, not %s!" % [name, state_owner.get_class()])

func state_call(delta: float) -> void:
	movementLogic(delta)
	
	if state_owner.is_on_floor():
		state_next.emit(grounded_state)

func movementLogic(delta: float):
	state_owner.velocity += state_owner.get_gravity() * delta
	state_owner.move_and_slide()
