class_name Beary extends Mob

@onready var play_dialogue = preload("res://Scenes/bossbattle_end.tscn")
var player_reference: Player


func _ready() -> void:
	max_health = 100
	initialize()
	max_speed = 400.0
	damage = 10
	name = "Beary"

func _on_detection_area_body_entered(body: Node) -> void:
	if body is Player:
		_player = body
		
		
func _on_hit_box_body_entered(body: Node) -> void:
	if body is Player:
		body.set_health(body.health - damage)
		_attack_sound.play()


func die():
	if _hit_box:
		_hit_box.queue_free()
	
	set_physics_process(false)
	collision_layer = 0
	collision_mask = 0

	_die_sound.play()
	_die_sound.finished.connect(queue_free)
	handle_dialogue()


func handle_dialogue():
	if health <= 0:
		var dialogue_instance = play_dialogue.instantiate()
		get_parent().add_child(dialogue_instance)
		if player_reference:
			dialogue_instance.connect("dialogue_finished", player_reference.resume_movement)
			player_reference.pause_movement()
