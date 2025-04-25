extends Node2D

signal dialogue_finished

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("day1")

func _on_timeline_ended() -> void:
	end_dialogue()

func end_dialogue():
	emit_signal("dialogue_finished")
	queue_free()
