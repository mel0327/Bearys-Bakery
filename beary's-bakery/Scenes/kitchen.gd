extends Node2D

@export var next_scene_path: String = "res://Scenes/pantry.tscn"

func _ready() -> void:
	var player_scene = preload("res://Scenes/player.tscn")
	var player = player_scene.instantiate()
	var spawn_point = $SpawnPoint
	player.global_position = spawn_point.global_position
	add_child(player)


func _on_scene_transition_to_pantry_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if ResourceLoader.exists(next_scene_path):
			get_tree().change_scene_to_file(next_scene_path)
		
