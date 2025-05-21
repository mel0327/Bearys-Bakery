extends Area2D

@onready var opening = preload("res://Scenes/opening.tscn")
@onready var day_1 = preload("res://Scenes/day1.tscn")
@onready var day_2 = preload("res://Scenes/day2.tscn")
@onready var label: Label = $Label

var is_player_near := false
var player_reference
var day := 0


func _ready() -> void:
	label.visible = false
	

func _unhandled_input(_event: InputEvent):
	if not is_player_near:
		return
	
	if Input.is_action_just_pressed("interact"):
		var dialogue_instance
		match day:
			0:
				dialogue_instance = opening.instantiate()
			1:
				dialogue_instance = day_1.instantiate()
			2:
				dialogue_instance = day_2.instantiate()
		
		
		get_parent().add_child(dialogue_instance)
		
		dialogue_instance.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

		
		if player_reference:
			player_reference.get_node("AnimatedSprite2D").visible = false
			player_reference.pause_movement()

		set_deferred("monitoring", false)


func _on_dialogue_finished():
	if player_reference:
		player_reference.get_node("AnimatedSprite2D").visible = true
		player_reference.resume_movement()
	day += 1
	if day > 2:
		get_tree().change_scene_to_file("res://Scenes/pantry.tscn")
		return
	set_deferred("monitoring", true)



func _on_body_entered(body: Player) -> void:
	if body.name == "Player":
		is_player_near = true
		label.visible = true
		player_reference = body


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		label.visible = false
