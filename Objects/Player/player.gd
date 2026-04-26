class_name PlayerController extends CharacterBody3D

@export var state_machine: State_Machine
@onready var camera_controller_anchor: Marker3D = $CameraControllerAnchor

func update_rotation(rotation_input) -> void:
	global_transform.basis = Basis.from_euler(rotation_input)

func _physics_process(delta: float) -> void:
	state_machine.state_call(delta)
