class_name PlayerController extends CharacterBody3D

@export var state_machine: State_Machine
@onready var camera_controller_anchor: Marker3D = $CameraControllerAnchor

@onready var camera_controller: CameraController = $CameraController
@onready var standing_collision: CollisionShape3D = $StandingCollision
@onready var crouch_collision: CollisionShape3D = $CrouchCollision
@onready var head_check: ShapeCast3D = $HeadCheck

func _ready() -> void:
	crouch_collision.disabled = true
	standing_collision.disabled = false

func update_rotation(rotation_input) -> void:
	global_transform.basis = Basis.from_euler(rotation_input)

func _physics_process(delta: float) -> void:
	state_machine.state_call(delta)
