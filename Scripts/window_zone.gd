extends Area2D


func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "res://Scenes/Player_1.tscn" or "res://Scenes/Player_2.tscn":
		game_over()
		
