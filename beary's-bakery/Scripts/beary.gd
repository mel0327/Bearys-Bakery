class_name Beary extends Mob

func _ready() -> void:
	health = 100.0
	max_speed = 400.0
	damage = 10
	name = "Beary"

func _on_detection_area_body_entered(body: Node) -> void:
	if body is Player:
		_player = body
		
		
func _on_hit_box_body_entered(body: Node) -> void:
	if body is Player:
		body.health -= damage
