class_name OptionsMenu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton as Button

signal exit_options_menu


func _ready() -> void:
	exit_button.button_down.connect(on_exit_button_pressed)
	set_process(false)

func on_exit_button_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)
