extends Area2D


func  scene_kosong() :
	get_tree().change_scene_to_file("res://Scenes/scene_kosong.tscn")
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "res://Scenes/Player_1.tscn" or "res://Scenes/Player_2.tscn":
		scene_kosong()
		
