extends Node
<<<<<<< Updated upstream
<<<<<<< Updated upstream
@onready var timer = $"../CanvasLayer/ControlUI/VBoxContainer/ControlTimer/Label"
@onready var level_timer = $"../Timer"
=======
@onready var timer = $"../CanvasLayer/ControlUI/VBoxContainer/TimerControl/Countdown"
@onready var timer_level = $"../Timer"
>>>>>>> Stashed changes
=======
@onready var timer = $"../CanvasLayer/ControlUI/VBoxContainer/TimerControl/Countdown"
@onready var timer_level = $"../Timer"
>>>>>>> Stashed changes

func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
	timer.text = str(int(level_timer.time_left))
=======
	timer.text = str(int(timer_level.time_left))
>>>>>>> Stashed changes
=======
	timer.text = str(int(timer_level.time_left))
>>>>>>> Stashed changes


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
	timer.text = str(int(level_timer.time_left))

=======
	timer.text = str(int(timer_level.time_left))
>>>>>>> Stashed changes
=======
	timer.text = str(int(timer_level.time_left))
>>>>>>> Stashed changes


func _on_timer_timeout() -> void:
	game_over()
