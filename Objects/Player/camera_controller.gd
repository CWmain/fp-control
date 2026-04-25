class_name CameraController extends Node3D

@export var debug: bool = false
@export_category("References")
@export var player_controller: PlayerController
@export var component_mouse_capture: mouseCapture
@export_category("Camera Settings")
@export_group("Camera Tilt")
@export_range(-PI/2, PI/3) var tilt_lower_limit: float = -PI/2
@export_range(PI/3, PI/2) var tilt_upper_range: float = PI/2

var _rotation: Vector3

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
