extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_scene = preload("res://Scenes/player.tscn")
	var player = player_scene.instantiate()
	var spawn_point = $SpawnPoint
	player.global_position = spawn_point.global_position
	add_child(player)
