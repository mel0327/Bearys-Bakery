extends CanvasLayer

@onready var restart_button: Button = $ColorRect/VBoxContainer/RestartButton
@onready var quit_button: Button = $ColorRect/VBoxContainer/QuitButton
@onready var music: AudioStreamPlayer = $Music

func _ready() -> void:
	print("Ending screen is ready!")

	
	get_tree().paused = false  
	set_process_input(true)
	set_process(true)

	
	music.play()

	
	restart_button.pressed.connect(_on_restart_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	

	restart_button.grab_focus()

func _on_restart_pressed() -> void:
	print("Restart clicked!")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	print("Quit clicked!")
	get_tree().quit()
