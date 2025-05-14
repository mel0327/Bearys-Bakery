class_name Player extends CharacterBody2D

@export var speed := 1000.0
@export var drag_factor := 10.0
@export var max_health := 5

var health := max_health: set = set_health
var can_move = true
var is_hurt = false
var last_direction = Vector2.ZERO

@onready var health_bar: ProgressBar = %HealthBar
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var timer: Timer = %HurtTimer

func _ready() -> void:
	health_bar.max_value = 4
	health_bar.value = health
	health_bar.visible = false

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
	
	if new_health < previous_health:
		health_bar.visible = true
		is_hurt = true
		animated_sprite.play("hurt")
		%HurtTimer.start()
		
	if health == 0:
		die()

func die() -> void:
	queue_free()

func pause_movement():
	can_move = false

func resume_movement():
	can_move = true

func update_animation() -> void:
	if is_hurt:
		return

	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if move_dir == Vector2.ZERO:
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
		return

	if move_dir == last_direction:
		return

	last_direction = move_dir

	if abs(move_dir.x) > abs(move_dir.y):
		if move_dir.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("right")
		else:
			animated_sprite.flip_h = true
			animated_sprite.play("left")
	else:
		if move_dir.y > 0:
			animated_sprite.play("front")
		else:
			animated_sprite.play("back")
	


func _on_hurt_timer_timeout() -> void:
	is_hurt = false
