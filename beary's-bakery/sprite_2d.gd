extends Sprite2D

const SPRITE_RIGHT := preload("res://bunny.png")



func _process(delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction_discrete := input_direction.sign()
	match direction_discrete:
		Vector2.RIGHT, Vector2.LEFT:
			texture = SPRITE_RIGHT
	if direction_discrete.length() > 0:
		flip_h = input_direction.x < 0.0



func _ready() -> void:
	pass
