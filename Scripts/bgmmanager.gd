extends AudioStreamPlayer

func _ready():
	# Connect the finished signal to ourselves
	finished.connect(_on_finished)
	play()

func _on_finished():
	# When the song ends, start it again immediately
	play()
