extends Control

func BackMainMenu():
	get_tree().change_scene_to_file("res://Scenes/Homescreen.tscn")

func _on_back_to_menu_button_pressed() -> void:
	BackMainMenu()
