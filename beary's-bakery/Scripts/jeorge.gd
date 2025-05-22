class_name Jeorge extends Mob

func _ready() -> void:
	max_health = 20
	initialize()
	max_speed = 400.0
	damage = 5
	name = "Jeorge"
	
	
func _on_detection_area_body_entered(body: Node) -> void:
	if body is Player:
		_player = body
		
		
func _on_hit_box_body_entered(body: Node) -> void:
	if body is Player:
		body.set_health(body.health - damage)
		_attack_sound.play()
