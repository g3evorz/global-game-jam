extends RigidBody2D

signal item_destroyed

@export var pickup_time: float = 20.0
@export var blink_start_time: float = 2.0
@onready var pickup_sfx = $AudioStreamPlayer
@onready var sprite = $Sprite2D
@onready var timer = $PickupTimer
@onready var area = $Area2D

var can_pickup: bool = false

func _ready():
	gravity_scale = 1.0
	lock_rotation = true
	
	# Connect Area2D signal
	if area:
		area.body_entered.connect(_on_area_body_entered)
	
	# Start timer
	if timer:
		timer.wait_time = pickup_time
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		timer.start()
	
	can_pickup = true

func _physics_process(delta):
	if not timer:
		return
		
	var time_remaining = timer.time_left
	
	# Blink effect
	if sprite and time_remaining <= blink_start_time and time_remaining > 0:
		var blink_speed = 10.0
		sprite.modulate.a = 0.5 + abs(sin(Time.get_ticks_msec() / 100.0 * blink_speed)) * 0.5

func _on_area_body_entered(body):
	if body.is_in_group("player") and can_pickup:
		pickup(body)

func pickup(player):
	can_pickup = false
	print("Item picked up!")
	pickup_sfx.play()
	await pickup_sfx.finished
	item_destroyed.emit()
	queue_free()

func _on_timer_timeout():
	print("Item expired!")
	item_destroyed.emit()
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
