extends Area2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle")

func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "res://Scenes/Player_1.tscn" or "res://Scenes/Player_2.tscn":
		game_over()
		
