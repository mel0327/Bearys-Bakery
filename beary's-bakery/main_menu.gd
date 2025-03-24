class_name MainMenu
extends Control

@onready var start_button = %StartButton as Button
@onready var exit_button = %ExitButton as Button
@onready var options_button = %OptionsButton as Button
@onready var start_level = preload("res://test.tscn")

func _ready() -> void:
	handle_connecting_signals()

func on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func on_options_button_pressed() -> void:
	print("settings")


func on_exit_button_pressed() -> void:
	get_tree().quit()

func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_button_pressed)
	options_button.button_down.connect(on_options_button_pressed)
	exit_button.button_down.connect(on_exit_button_pressed)
	
