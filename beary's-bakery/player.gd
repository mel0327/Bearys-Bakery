class_name Player extends CharacterBody2D

@export var speed := 1000.0
@export var drag_factor := 10.0
@export var max_health := 5

func _physics_process(delta: float) -> void:
	var move_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	move_and_slide()
