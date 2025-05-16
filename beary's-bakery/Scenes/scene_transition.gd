extends Area2D


@export var next_scene_path: String = "res://Scenes/kitchen.tscn"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if ResourceLoader.exists(next_scene_path):
			get_tree().change_scene_to_file(next_scene_path)
		
