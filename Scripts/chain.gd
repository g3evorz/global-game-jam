extends Node2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var max_chain_length: float = 300.0
@export var chain_stiffness: float = 0.5  # How hard the chain pulls (0-1)

# Visual settings
@export var sag_amount: float = 50.0
@export var chain_segments: int = 20
@export var chain_width: float = 3.0
@export var chain_color: Color = Color.GRAY
@export var tension_color: Color = Color.RED

@onready var line: Line2D = $Line2D

func _ready():
	# Create Line2D if it doesn't exist
	if not has_node("Line2D"):
		line = Line2D.new()
		line.name = "Line2D"
		add_child(line)
	
	line.width = chain_width
	line.default_color = chain_color

func _physics_process(delta: float) -> void:
	apply_chain_constraint()
	update_chain_visual()

func apply_chain_constraint() -> void:
	if not player1 or not player2:
		return
	
	var distance = player1.global_position.distance_to(player2.global_position)
	
	# Only pull when chain is stretched
	if distance > max_chain_length:
		var direction = (player2.global_position - player1.global_position).normalized()
		var excess = distance - max_chain_length
		
		# Pull both players toward each other
		var pull_amount = excess * chain_stiffness
		
		# Move both players toward center
		player1.global_position += direction * pull_amount
		player2.global_position -= direction * pull_amount

func update_chain_visual() -> void:
	if not player1 or not player2 or not line:
		return
	
	line.clear_points()
	
	var start = player1.global_position
	var end = player2.global_position
	var distance = start.distance_to(end)
	
	# Calculate tension (0 = loose, 1 = fully stretched)
	var chain_tension = clamp(distance / max_chain_length, 0.0, 1.0)
	
	# Adjust sag based on tension (less sag when stretched)
	var current_sag = sag_amount * (1.0 - chain_tension * 0.7)
	
	# Create curved chain with segments
	for i in range(chain_segments + 1):
		var t = float(i) / float(chain_segments)
		var point = start.lerp(end, t)
		
		# Add parabolic sag (curve downward)
		var sag = sin(t * PI) * current_sag
		point.y += sag
		
		line.add_point(point)
	
	# Change color based on tension
	if chain_tension > 0.9:
		line.default_color = tension_color  # Red when almost breaking
	elif chain_tension > 0.7:
		line.default_color = chain_color.lerp(tension_color, 0.5)  # Orange
	else:
		line.default_color = chain_color  # Normal gray
