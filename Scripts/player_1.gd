extends CharacterBody2D


@export var speed: float = 100.0
@export var jump_velocity: float = -300.0

@export var gravity: float = 980.0
@export var acceleration: float = 800.0
@export var friction: float = 1000.0
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
		
	

	
