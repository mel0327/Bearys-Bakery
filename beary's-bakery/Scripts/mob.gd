class_name Mob extends CharacterBody2D

@export var max_speed := 400.0
@export var acceleration := 700.0
@export var max_health := 100
var health: int
@export var damage := 1 

var _player: Player = null

@onready var _detection_area: Area2D = %DetectionArea
@onready var _hit_box: Area2D = %HitBox
@onready var _hurt_sound: AudioStreamPlayer = %HurtSound
@onready var _die_sound: AudioStreamPlayer = %DieSound
@onready var health_bar: ProgressBar = %HealthBar
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var _attack_sound: AudioStreamPlayer = %AttackSound

func _ready() -> void:
	initialize()
	_detection_area.body_entered.connect(_on_detection_area_body_entered)
	_detection_area.body_exited.connect(_on_detection_area_body_exited)
	_hit_box.body_entered.connect(_on_hit_box_body_entered)
	
	
func initialize() -> void:
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health
	health_bar.visible = false

func set_health(new_health: int) -> void:
	var previous_health := health
	health = clamp(new_health, 0, max_health)
	health_bar.value = health

	if health < previous_health:
		health_bar.visible = true
		_hurt_sound.play()

	if health <= 0:
		die()

func die() -> void:
	Global.dead_mobs[name] = true
	if _hit_box == null:
		return
	set_physics_process(false)
	collision_layer = 0
	collision_mask = 0
	_hit_box.queue_free()

	_die_sound.play()
	_die_sound.finished.connect(queue_free)

func _physics_process(delta: float) -> void:
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		var direction := global_position.direction_to(_player.global_position)
		var distance := global_position.distance_to(_player.global_position)
		var speed := max_speed if distance > 120.0 else max_speed * distance / 120.0
		var desired_velocity := direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()
	update_animation()

func take_damage(amount:int) -> void:
	set_health(health-amount)


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player hit — playing sound.")
		body.set_health(body.health - damage)
		_attack_sound.play()
	elif body is Bullet:
		take_damage(body.damage)
		body.queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		_player = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		_player = body


func update_animation() -> void:
	if animated_sprite == null:
		return
		
	if velocity.length() < 5:
		if animated_sprite.animation != "idle":
				animated_sprite.play("idle")
		else:
			animated_sprite.stop()
		return
		
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			animated_sprite.play("right")
		else:
			animated_sprite.play("left")
	else:
		if velocity.y > 0:
			animated_sprite.play("front")
		else:
			animated_sprite.play("back")
