extends StaticBody3D

@export var player: PlayerController

@export var shooting: bool = false
@onready var damage_timer: Timer = $DamageTimer

func  _ready() -> void:
	if shooting == true:
		damage_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_timer_timeout() -> void:
	player.cameraEffects.add_damage_kick(20.0, 20.0, global_position)
