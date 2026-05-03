extends State

@export var acceleration: float = 20
@export var deceleration: float = 20

@export var grounded_state: State

var _input_dir : Vector2 = Vector2.ZERO
var _movement_velocity : Vector3 = Vector3.ZERO
var speed : float = 2.5

func _validate_owner(): pass

func state_call(delta: float) -> void:
	# Disable standing collision when crouching
	state_owner.crouch_collision.disabled = false
	state_owner.standing_collision.disabled = true
	
	state_owner.camera_controller.update_camera_height(delta, -1)
	
	if !Input.is_action_pressed("crouch") and !state_owner.head_check.is_colliding():
		# Check the "head" raycast
		state_next.emit(grounded_state)
		
	movementLogic(delta)

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
	
	state_owner.move_and_slide()
