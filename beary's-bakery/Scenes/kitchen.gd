extends Node2D


@onready var music = $AudioStreamPlayer
@onready var loop_timer = $LoopTimer
var fade_duration := 1.5


func _input(event):
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			PauseMenu.resume()
		else:
			PauseMenu.pause()


func _ready() -> void:
	var player_scene = preload("res://Scenes/player.tscn")
	var player = player_scene.instantiate()
	var spawn_point = $SpawnPoint
	player.global_position = spawn_point.global_position
	add_child(player)
	music.volume_db = 0
	music.play()
	loop_timer.timeout.connect(_on_loop_timer_timeout)


func _on_scene_transition_to_pantry_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if ResourceLoader.exists("res://Scenes/pantry.tscn"):
			get_tree().change_scene_to_file("res://Scenes/pantry.tscn")
		


func _on_scene_transition_to_basement_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if ResourceLoader.exists("res://Scenes/basement.tscn"):
			get_tree().change_scene_to_file("res://Scenes/basement.tscn")
			


func exit_tree():
	var tween := create_tween()
	tween.tween_property(music, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(music, "stop"))

func _on_loop_timer_timeout():
	music.play()
