extends Control

@onready var animation = $AnimationPlayer
@onready var fadeSet = $FadeSet

func _ready() -> void:
	fadeSet.hide()

func _on_start_pressed() -> void:
	fadeSet.show()
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	fadeSet.show()
	animation.play("fade_out")
	await animation.animation_finished
	get_tree().quit()
