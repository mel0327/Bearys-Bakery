extends Area2D


@onready var play_dialogue = preload("res://Scenes/day3.tscn")
@onready var label: Label = $Label

var is_player_near := false
var player_reference
var mob_reference: Mob


func _ready() -> void:
	label.visible = false
	mob_reference = get_parent().get_node("Hammy")
	if mob_reference:
		mob_reference.connect("mob_died", Callable(self, "_on_mob_died"))


func _unhandled_input(_event: InputEvent):
	if not is_player_near:
		return
	
	if Input.is_action_just_pressed("interact"):
		var dialogue_instance = play_dialogue.instantiate()
		get_parent().add_child(dialogue_instance)
		
		dialogue_instance.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

		
		if player_reference:
			
			player_reference.get_node("AnimatedSprite2D").visible = false
			player_reference.pause_movement()

		get_tree().change_scene_to_file("res://Scenes/kitchen.tscn")
		set_deferred("monitoring", false)


func _on_dialogue_finished():
	if player_reference:
		player_reference.get_node("AnimatedSprite2D").visible = true
		player_reference.resume_movement()




func _on_body_entered(body: Player) -> void:
	if body.name == "Player":
		is_player_near = true
		player_reference = body


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false


func _on_mob_died():
	label.visible = true
