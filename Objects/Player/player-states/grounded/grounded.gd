extends State

@export var acceleration: float = 20
@export var deceleration: float = 20
@export var jump_speed: float = 500

@export var air_state: State

var _input_dir : Vector2 = Vector2.ZERO
var _movement_velocity : Vector3 = Vector3.ZERO
var speed : float = 5.0

func _validate_owner():
	assert(state_owner is CharacterBody3D, "%s: state_owner must be a CharacterBody3D, not %s!" % [name, state_owner.get_class()])

func state_call(delta: float) -> void:
	movementLogic(delta)
	
	if !state_owner.is_on_floor():
		state_next.emit(air_state)

func movementLogic(delta: float) -> void:
	_input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	var current_velocity = Vector2(_movement_velocity.x, _movement_velocity.z)
	var direction = (state_owner.transform.basis * Vector3(_input_dir.x, 0.0, _input_dir.y)).normalized()
	
	if direction:
		current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * speed, acceleration * delta)
	else:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	_movement_velocity = Vector3(current_velocity.x, state_owner.velocity.y, current_velocity.y)
	state_owner.velocity = _movement_velocity
	
	if Input.is_action_just_pressed("move_jump"):
		state_owner.velocity.y += jump_speed*delta 
	
	state_owner.move_and_slide()
