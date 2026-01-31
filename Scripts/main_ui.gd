extends Control

@onready var fade_out = $"Fade Out"
@onready var colorrect = $ColorRect
@onready var maskOn = $Panel/MarginContainer/MaskOn
@onready var maskOff = $Panel/MarginContainer/MaskOff

func _ready() -> void:
	maskOff.hide()
	fade_out.play("fadeout")
	await fade_out.animation_finished
	colorrect.hide()
	
	
func _on_player_2_mask_off() -> void:
	maskOff.show()
