extends Area2D


@onready var play_dialogue = preload("res://Scenes/dialogue_2.1.tscn")
@onready var label: Label = $Label

var is_player_near := false
var player_reference


func _ready() -> void:
	label.visible = false
	

func _unhandled_input(event: InputEvent):
	if not is_player_near:
		return
	
	if Input.is_action_just_pressed("interact"):
		var dialogue_instance = play_dialogue.instantiate()
		get_parent().add_child(dialogue_instance)
		
		dialogue_instance.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

		
		if player_reference:
			
			player_reference.get_node("Sprite2D").visible = false
			player_reference.get_node("HealthBar").visible = false
			player_reference.pause_movement()

		set_deferred("monitoring", false)


func _on_dialogue_finished():
	if player_reference:
		player_reference.get_node("Sprite2D").visible = true
		player_reference.get_node("HealthBar").visible = true
		player_reference.resume_movement()
	#set_deferred("monitoring", true)



func _on_body_entered(body: Player) -> void:
	if body.name == "Player":
		is_player_near = true
		label.visible = true
		player_reference = body


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		label.visible = false
