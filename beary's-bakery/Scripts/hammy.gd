class_name Hammy extends Mob

func _ready() -> void:
	health = 10.0
	max_speed = 400.0
	damage = 5
	name = "Hammy"


func _on_detection_area_body_entered(body: Node) -> void:
	if body is Player:
		_player = body
		
		
func _on_hit_box_body_entered(body: Node) -> void:
	if body is Player:
		body.health -= damage

func die():
	if health == 0:
		Dialogic.start("day2_end")
		
	if _hit_box == null:
		return
	set_physics_process(false)
	collision_layer = 0
	collision_mask = 0
	_hit_box.queue_free()

	_die_sound.play()
	_die_sound.finished.connect(queue_free)
