extends Area2D

func  game_over() :
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player_1" or "Player_2" or "mask_drop":
		game_over()
		
