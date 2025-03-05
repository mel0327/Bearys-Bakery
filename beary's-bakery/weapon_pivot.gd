extends Node2D


func _process(delta: float) -> void:
	var aim_direction := Vector2.ZERO
	aim_direction = global_position.direction_to(get_global_mouse_position())

	rotation = aim_direction.angle()
