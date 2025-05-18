class_name Hammy extends Mob

signal mob_died

@onready var play_dialogue = preload("res://Scenes/hammy_dialogue.tscn")
var player_reference: Player


func _ready() -> void:
	health = 100.0
	max_speed = 400.0
	damage = 5
	name = "Hammy"


func _on_detection_area_body_entered(body: Node) -> void:
	if body is Player:
		_player = body
		player_reference = body


func _on_hit_box_body_entered(body: Node) -> void:
	if body is Player:
		body.set_health(body.health - damage)
		_attack_sound.play()

func die():
	if health <= 0:
		var dialogue_instance = play_dialogue.instantiate()
		get_parent().add_child(dialogue_instance)
		dialogue_instance.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
		
		emit_signal("mob_died")

		if player_reference:
			player_reference.get_node("AnimatedSprite2D").visible = false
			player_reference.pause_movement()

	if _hit_box == null:
		return
	set_physics_process(false)
	collision_layer = 0
	collision_mask = 0
	_hit_box.queue_free()

	_die_sound.play()
	_die_sound.finished.connect(queue_free)


func _on_dialogue_finished():
	if player_reference:
		player_reference.get_node("AnimatedSprite2D").visible = true
		player_reference.resume_movement()
