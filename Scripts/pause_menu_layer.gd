extends CanvasLayer

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("ui_pause") and !event.is_echo():
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	visible = true
	get_tree().paused = true

func resume_game():
	visible = false
	get_tree().paused = false


func _on_resume_button_pressed() -> void:
	resume_game()


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Homescreen.tscn")
