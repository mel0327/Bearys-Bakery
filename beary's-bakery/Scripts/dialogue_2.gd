class_name Dialogues extends Node2D

signal dialogue_finished
#@export var weapon_instance: Weapon = null


func _ready() -> void:
	#print("Current Node Path: ", self.get_path())

	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("opening")

	#if weapon_instance != null:
		#disable_weapon(true)
	#else:
		#print("Weapon instance is null!")


func _on_timeline_ended() -> void:
	end_dialogue()


func end_dialogue():
	#if weapon_instance != null:
		#disable_weapon(false)
	emit_signal("dialogue_finished")
	queue_free()


#func disable_weapon(is_disabled: bool) -> void:
	#if weapon_instance:
		#weapon_instance.is_dialogue_active = is_disabled
		#print("Weapon disabled: ", is_disabled)
	#else:
		#print("Weapon instance not found!")
