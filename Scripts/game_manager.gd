extends Node
@onready var timer = $"../CanvasLayer/ControlUI/VBoxContainer/TimerControl/Countdown"
@onready var timer_level = $"../Timer"
@onready var bgm_player = $"../AudioStreamPlayer"

func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.text = str(int(timer_level.time_left))
	bgm_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.text = str(int(timer_level.time_left))


func _on_timer_timeout() -> void:
	game_over()
	

func stop_music():
	bgm_player.stop()

func change_volume(value: float):
	# Volume is in decibels (dB). 0 is original volume, -80 is silent.
	bgm_player.volume_db = value
