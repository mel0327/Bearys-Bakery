class_name Player extends CharacterBody2D

@export var speed := 1000.0
@export var drag_factor := 10.0
@export var max_health := 5

var health := max_health: set = set_health
var can_move = true

@onready var health_bar: ProgressBar = %HealthBar
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _ready() -> void:
	health_bar.max_value = 4
	health_bar.value = health

func _physics_process(delta):
	if can_move:
		handle_movement(delta)

func handle_movement(delta: float) -> void:
#

	var move_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	move_and_slide()

func set_health(new_health: int) -> void:
	var previous_health := health
	health = clampi(new_health, 0, max_health)
	health_bar.value = health
	if health == 0:
		die()

func die() -> void:
	queue_free()

func pause_movement():
	can_move = false

func resume_movement():
	can_move = true
