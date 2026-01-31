extends Node
@onready var timer = $"../CanvasLayer/ControlUI/VBoxContainer/TimerControl/Countdown"
@onready var timer_level = $"../Timer"

func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.text = str(int(timer_level.time_left))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.text = str(int(timer_level.time_left))


func _on_timer_timeout() -> void:
	game_over()
