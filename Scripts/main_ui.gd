extends Control

@onready var fade_out = $"Fade Out"
@onready var colorrect = $ColorRect
func _ready() -> void:
	fade_out.play("fadeout")
	await fade_out.animation_finished
	colorrect.hide()
	
