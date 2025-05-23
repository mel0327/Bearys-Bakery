extends Dialogues


func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("day3")
	get_tree().change_scene_to_file("res://Scenes/kitchen.tscn")
