class_name Day2_End extends Node2D


signal dialogue_finished


func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("day2_end")
	for connection in dialogue_finished.get_connections():
		print(connection)


func _on_timeline_ended() -> void:
	end_dialogue()


func end_dialogue():
	for connection in dialogue_finished.get_connections():
		print(connection)
	emit_signal("dialogue_finished")


	queue_free()
