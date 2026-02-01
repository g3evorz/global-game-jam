extends CharacterBody2D

@export var SPEED: float = 300.0
@export var MAX_SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0
@export var ACCELERATION: float = 8.0
@export var FRICTION: float = 14.5

@onready var sprite: AnimatedSprite2D = $Sprite2D
var is_jumping: bool = false
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
	
	# Reset jumping state when landing
	if is_on_floor() and is_jumping:
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("Jump_1") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		sprite.play("Jump") # Trigger Jump immediately

	# Get the input direction
	var direction := Input.get_axis("Left_1", "Right_1")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0 # Flip sprite based on movement
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) 
	
	# Update animations based on movement state
	update_animation()

# --- ANIMATION LOGIC ---
func update_animation():
	if is_jumping or not is_on_floor():
		if sprite.animation != "Jump":
			sprite.play("Jump")
	elif abs(velocity.x) > 10:
		if sprite.animation != "Walk":
			sprite.play("Walk")
	else:
		if sprite.animation != "Idle":
			sprite.play("Idle")

func _ladder_detect():
	if $LadderDetectRay.is_colliding() and !is_on_floor():
		if Input.is_action_pressed("up_1") or Input.is_action_pressed("down_1"):
			on_ladder = true
			is_jumping = false 
			
			# Get the ladder object itself
			var ladder_object = $LadderDetectRay.get_collider()
			
			if ladder_object:
				# Use the ladder's global_position directly to snap to its center
				var desired_x_pos: float = ladder_object.global_position.x
				
				if abs(global_position.x - desired_x_pos) > 1.0: # Only tween if far enough away
					var x_pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
					x_pos_tween.tween_property(self, "global_position:x", desired_x_pos, 0.05)
	else:
		on_ladder = false

func ladder_movement(delta: float):
	var y_input: float = Input.get_action_strength("down_1") - Input.get_action_strength("up_1")
	var velocity_weight: float = delta * (ACCELERATION if y_input else FRICTION)
	velocity.y = lerp(velocity.y, y_input * MAX_SPEED, velocity_weight)
	velocity.x = 0.0
	$Sprite2D.rotation_degrees = lerp($Sprite2D.rotation_degrees, 0.0, 16.5 * delta)
	
	# --- LADDER ANIMATION LOGIC ---
	if abs(y_input) > 0.1:
		if sprite.animation != "Climb":
			sprite.play("Climb")
		elif not sprite.is_playing():
			sprite.play()
	else:
		if sprite.animation == "Climb":
			sprite.pause() # Pause frame when not moving up/down
