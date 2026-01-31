extends CharacterBody2D


@export var SPEED: float  = 300.0
@export var MAX_SPEED: float  = 300.0
@export var JUMP_VELOCITY: float  = -400.0
@export var ACCELERATION: float  = 8.0
@export var FRICTION: float = 14.5
var on_ladder: bool = false


func _physics_process(delta: float) -> void:
	_ladder_detect()
	if on_ladder:
		ladder_movement(delta)
	else:
		movement(delta) 

	move_and_slide()
func movement(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump_1") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left_1", "Right_1")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) 
func _ladder_detect():
	if $LadderDetectRay.is_colliding() and !is_on_floor():
		if Input.is_action_pressed("up_1") or Input.is_action_pressed("down_1"):
			on_ladder = true
			
			var desired_x_pos: float = $LadderDetectRay.get_collider().get_child($LadderDetectRay.get_collider_shape()).global_position.x
			if global_position.x != desired_x_pos:
				var x_pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
				x_pos_tween.tween_property(self, "global_position:x",desired_x_pos, 0.05)
				 
	else:
		on_ladder = false
func ladder_movement(delta: float):
	var y_input: float = Input.get_action_strength("down_1") - Input.get_action_strength("up_1")
	var velocity_weight: float = delta * (ACCELERATION if y_input else FRICTION)
	velocity.y = lerp(velocity.y, y_input * MAX_SPEED, velocity_weight)
	velocity.x = 0.0
	$Sprite2D.rotation_degrees = lerp($Sprite2D.rotation_degrees, 0.0, 16.5 * delta)
	
