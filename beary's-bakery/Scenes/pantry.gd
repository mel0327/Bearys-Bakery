extends Node2D

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


func _on_cake_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if ResourceLoader.exists("res://Scenes/kitchen.tscn"):
			get_tree().change_scene_to_file("res://Scenes/kitchen.tscn")
