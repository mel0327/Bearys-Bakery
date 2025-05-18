extends Control

@onready var pause_menu_scene = preload("res://Scenes/pause_menu.tscn")
var pause_menu: CanvasLayer
var current_scene: Node = null

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
	
	
func load_scene(scene_path: String) -> void:
	if current_scene and current_scene.is_inside_tree():
		current_scene.queue_free()
		
	current_scene = load(scene_path).instantiate()
	add_child(current_scene)
