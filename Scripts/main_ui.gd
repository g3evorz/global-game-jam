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
	var tween = create_tween().set_loops(6)
	tween.tween_property(maskOn, "modulate", Color(1, 0, 0), 0.25)
	tween.tween_property(maskOn, "modulate", Color(1, 1, 1), 0.25)
	await tween.finished
	maskOff.show()


func _on_player_2_mask_on() -> void:
	maskOff.hide()
