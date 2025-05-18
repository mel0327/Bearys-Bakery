extends CanvasLayer

 

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/bakery.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
