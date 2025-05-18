extends CanvasLayer


func _ready() -> void:
	hide()
	set_process_input(true)


func pause():
	show()
	get_tree().paused = true
	
func resume():
	hide()
	get_tree().paused = false
	


func _on_resume_pressed() -> void:
	resume()



func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
