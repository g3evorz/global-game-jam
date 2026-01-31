extends Control

func reset():
	get_tree().change_scene_to_file("res://Scenes/Homescreen.tscn")

func _on_retry_button_pressed() -> void:
	reset()
