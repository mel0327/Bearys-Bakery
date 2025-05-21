class_name Day3_End extends Node2D


signal dialogue_finished


func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("bossbattle")
	for connection in dialogue_finished.get_connections():
		print(connection)


func _on_timeline_ended() -> void:
	end_dialogue()


func end_dialogue():
	print("ending_dialog")
	for connection in dialogue_finished.get_connections():
		print(connection)
	emit_signal("dialogue_finished")

	queue_free()
