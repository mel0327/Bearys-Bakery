extends Control

@onready var pause_menu_scene = preload("res://Scenes/pause_menu.tscn")
var pause_menu: CanvasLayer

func _ready() -> void:
	pause_menu = pause_menu_scene.instantiate()
	add_child(pause_menu)
	pause_menu.hide()
	get_tree().paused = false
	pause_menu.set_process(true)

	
func _input(event):
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			PauseMenu.resume()
		else:
			PauseMenu.pause()
			
func _pause_game():
	get_tree().paused = true
	pause_menu.show()

	
func _unpause_game():
	get_tree().paused = false
	pause_menu.hide()
	
