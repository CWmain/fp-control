class_name CameraController extends Node3D

@export var debug: bool = false
@export_category("References")
@export var player_controller: PlayerController
@export var component_mouse_capture: mouseCapture
@export_category("Camera Settings")
@export_group("Camera Tilt")
@export_range(-PI/2, PI/3) var tilt_lower_limit: float = -PI/2
@export_range(PI/3, PI/2) var tilt_upper_range: float = PI/2

@export_group("Camera Vertical Movement")
@export var crouch_offset: float = 0.0
@export var crouch_speed: float = 5.0
# crouch_margin is used to set it to offset / DEFAULT_HEIGHT when "close enough"
@export var crouch_margin: float = 0.01
var _rotation: Vector3

const DEFAULT_HEIGHT: float = 0.7

func _process(delta: float) -> void:
	update_camera_rotation(component_mouse_capture._mouse_input)

func update_camera_rotation(input: Vector2) -> void:
	_rotation.x += input.y
	_rotation.y += input.x
	_rotation.x = clamp(_rotation.x, tilt_lower_limit, tilt_upper_range)
	
	var _player_rotation = Vector3(0.0, _rotation.y, 0.0)
	var _camera_rotation = Vector3(_rotation.x, 0.0 ,0.0)
	
	player_controller.camera_controller_anchor.transform.basis = Basis.from_euler(_camera_rotation)
	player_controller.update_rotation(_player_rotation)
	
	global_transform = player_controller.camera_controller_anchor.get_global_transform_interpolated()
	
	_rotation.z = 0

func update_camera_height(delta: float, direction: int) -> void:
	var current_y = player_controller.camera_controller_anchor.position.y
	var target_y = crouch_offset if direction < 0 else DEFAULT_HEIGHT
	
	# Do nothing if already at desired height
	if (current_y == target_y):
		return

	current_y = lerp(current_y, target_y, crouch_speed * delta)
	if current_y - crouch_margin < crouch_offset: current_y = crouch_offset
	if current_y + crouch_margin > DEFAULT_HEIGHT: current_y = DEFAULT_HEIGHT

	player_controller.camera_controller_anchor.position.y = current_y
