extends State

@export var grounded_state: State
@export var fall_velocity_threshold: float = -5.0

var _previous_fall_velocity: float = 0

func _validate_owner():
	assert(state_owner is PlayerController, "%s: state_owner must be a PlayerController, not %s!" % [name, state_owner.get_class()])

func state_call(delta: float) -> void:
	movementLogic(delta)
	
	if state_owner.is_on_floor():
		print(_previous_fall_velocity)
		if _previous_fall_velocity < fall_velocity_threshold:
			state_owner.cameraEffects.add_fall_kick(2.0)
		state_next.emit(grounded_state)
		
	_previous_fall_velocity = state_owner.velocity.y
func movementLogic(delta: float):
	state_owner.velocity += state_owner.get_gravity() * delta
	state_owner.move_and_slide()
