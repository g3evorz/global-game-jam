extends Camera2D

@export var player: CharacterBody2D

# Set these to your project's Window Width/Height (found in Project Settings)
@export var view_width: float = 1152.0 
@export var view_height: float = 648.0 

func _process(_delta: float) -> void:
	if not player:
		return

	# Determine the "index" of the current screen
	# If player.y is 100, row is 0. If player.y is 700, row is 1.
	var current_row = floor(player.global_position.y / view_height)
	var current_col = floor(player.global_position.x / view_width)

	# Calculate the target center point for the camera
	var target_y = (current_row * view_height) + (view_height / 2.0)
	var target_x = (current_col * view_width) + (view_width / 2.0)

	# Apply the position instantly
	global_position = Vector2(target_x, target_y)
