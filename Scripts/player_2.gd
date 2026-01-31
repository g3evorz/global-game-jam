extends CharacterBody2D

signal maskOff
signal maskOn

@export var SPEED: float  = 300.0
@export var MAX_SPEED: float  = 300.0
@export var JUMP_VELOCITY: float  = -400.0
@export var ACCELERATION: float  = 8.0
@export var FRICTION: float = 14.5

@export var item_scene: PackedScene
@export var drop_interval: float = 15.0
var drop_offset: Vector2 = Vector2(0, 50)
var drop_timer: Timer

var on_ladder: bool = false
var can_move: bool = true

func _ready() -> void:
	drop_timer = Timer.new()
	drop_timer.wait_time = drop_interval
	drop_timer.autostart = true
	drop_timer.timeout.connect(_on_drop_timer_timeout)
	add_child(drop_timer)

func _physics_process(delta: float) -> void:
	_ladder_detect()
	if can_move:
		if on_ladder:
			ladder_movement(delta)
		else:
			movement(delta)
	else:
		if not is_on_floor() and not on_ladder:
			velocity += get_gravity() * delta
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func movement(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("Jump_2") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left_2", "Right_2")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) 
func _ladder_detect():
	if $LadderDetectRay.is_colliding() and !is_on_floor():
		if Input.is_action_pressed("up_2") or Input.is_action_pressed("down_2"):
			on_ladder = true
			
			var desired_x_pos: float = $LadderDetectRay.get_collider().get_child($LadderDetectRay.get_collider_shape()).global_position.x
			if global_position.x != desired_x_pos:
				var x_pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
				x_pos_tween.tween_property(self, "global_position:x",desired_x_pos, 0.05)
				 
	else:
		on_ladder = false
func ladder_movement(delta: float):
	var y_input: float = Input.get_action_strength("down_2") - Input.get_action_strength("up_2")
	var velocity_weight: float = delta * (ACCELERATION if y_input else FRICTION)
	velocity.y = lerp(velocity.y, y_input * MAX_SPEED, velocity_weight)
	velocity.x = 0.0
	$Sprite2D.rotation_degrees = lerp($Sprite2D.rotation_degrees, 0.0, 16.5 * delta)
	
func _on_drop_timer_timeout():
	drop_item()
	
func drop_item():
	if not item_scene:
		return
	var item = item_scene.instantiate()
	item.global_position = global_position + drop_offset
	
	maskOff.emit()
	
	item.item_destroyed.connect(_on_item_destroyed)
	get_parent().add_child(item)
	can_move = false
	print("item dropped")
	
func _on_item_destroyed():
	maskOn.emit()
	can_move = true
	
	
