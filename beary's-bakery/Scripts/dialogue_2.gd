extends Node2D

signal dialogue_finished
var weapon_instance: Node = null

func _ready() -> void:
	weapon_instance = get_node("res://Scenes/weapon.tscn")

	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("opening")
	disable_weapon(true)

func _on_timeline_ended() -> void:
	end_dialogue()

func end_dialogue():
	disable_weapon(false)
	emit_signal("dialogue_finished")
	queue_free()

func disable_weapon(is_disabled: bool) -> void:
	if weapon_instance:
		weapon_instance.is_dialogue_active = is_disabled
