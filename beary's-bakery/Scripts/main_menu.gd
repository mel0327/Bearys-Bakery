class_name MainMenu
extends Control

@onready var music = $AudioStreamPlayer
@onready var loop_timer = $LoopTimer
var fade_duration := 1.5

@onready var start_button = %StartButton as Button
@onready var exit_button = %ExitButton as Button
@onready var options_button = %OptionsButton as Button
@onready var options_menu = $OptionsMenu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer
@onready var start_level = preload("res://Scenes/bakery.tscn")

func _ready() -> void:
	for node in get_tree().get_root().get_children():
		if node != self and node.has_node("AudioStreamPlayer"):
			node.get_node("AudioStreamPlayer").stop()

	music.stop()
	music.volume_db = 0
	music.play()
	handle_connecting_signals()
	loop_timer.timeout.connect(_on_loop_timer_timeout)

func on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func on_options_button_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true


func on_exit_button_pressed() -> void:
	get_tree().quit()
	
func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false


func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_button_pressed)
	options_button.button_down.connect(on_options_button_pressed)
	exit_button.button_down.connect(on_exit_button_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	
	
func exit_tree():
	var tween := create_tween()
	tween.tween_property(music, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(music, "stop"))

func _on_loop_timer_timeout():
	music.play()
