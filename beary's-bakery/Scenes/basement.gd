extends Node2D

@onready var music = $AudioStreamPlayer
@onready var loop_timer = $LoopTimer
@onready var ending_screen_scene = preload("res://Scenes/ending_screen.tscn")
var ending_screen_shown := false
var fade_duration := 1.5


func _input(event):
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			PauseMenu.resume()
		else:
			PauseMenu.pause()

func _ready() -> void:
	var mob_names = ["Beary"]
	for mob_name in mob_names:
		if Global.dead_mobs.get(mob_name, false):
			if has_node(mob_name):
				get_node(mob_name).queue_free()
	var player_scene = preload("res://Scenes/player.tscn")
	var player = player_scene.instantiate()
	var spawn_point = $SpawnPoint
	player.global_position = spawn_point.global_position
	add_child(player)
	
	for node in get_tree().get_root().get_children():
		if node != self and node.has_node("AudioStreamPlayer"):
			node.get_node("AudioStreamPlayer").stop()
			
	music.volume_db = 0
	music.play()
	loop_timer.timeout.connect(_on_loop_timer_timeout)


func _on_cake_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if ResourceLoader.exists("res://Scenes/bakery.tscn"):
			get_tree().change_scene_to_file("res://Scenes/bakery.tscn")
			
func exit_tree():
	var tween := create_tween()
	tween.tween_property(music, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(music, "stop"))

func _on_loop_timer_timeout():
	music.play()

func show_ending_screen():
	if not ending_screen_shown:
		ending_screen_shown = true
		var ending_screen = ending_screen_scene.instantiate()
		add_child(ending_screen)
		Global.allow_pause_menu = false
