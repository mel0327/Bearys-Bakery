class_name Player extends CharacterBody2D

@export var speed := 1000.0
@export var drag_factor := 10.0
@export var max_health := 5

var health := max_health: set = set_health
var can_move = true

@onready var health_bar: ProgressBar = %HealthBar
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

func _ready() -> void:
	health_bar.max_value = 4
	health_bar.value = health

func _physics_process(delta):
	if can_move:
		handle_movement(delta)
		update_animation()

func handle_movement(delta: float) -> void:

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

func update_animation() -> void:
	var last_motion = get_last_motion()
	if last_motion.x == 0 and last_motion.y == 0:
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
		return
	if (abs(last_motion.x) > abs(last_motion.y)):	
		if last_motion.x > 0:
			#print ("right")
			animated_sprite.flip_h = true
			if animated_sprite.animation != "right":
				animated_sprite.play("right")
		elif last_motion.x < 0:
			#print("left")
			animated_sprite.flip_h = true
			if animated_sprite.animation != "left":
				animated_sprite.play("left")
	else:
		if last_motion.y > 0:
			#print ("Up")
			animated_sprite.flip_h = true
			if animated_sprite.animation != "front":
				animated_sprite.play("front")
		elif last_motion.y < 0:
			#print("back")
			animated_sprite.flip_h = true
			if animated_sprite.animation != "back":
				animated_sprite.play("back")
	
