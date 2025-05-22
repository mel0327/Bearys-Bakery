class_name Bullet extends Area2D

var is_dialogue_active := false


@export var speed := 5000.0
@export var damage := 5
@onready var _hit_sound: AudioStreamPlayer = %HitSound


var max_range := 250.0
var _traveled_distance := 0.0


func _physics_process(delta: float) -> void:
	var distance := speed * delta
	var motion := Vector2.RIGHT.rotated(rotation) * distance

	position += motion

	_traveled_distance += distance
	if _traveled_distance >= max_range:
		_destroy()
	
	

func _on_body_entered(body: Node2D) -> void:
	if body is Mob:
		body.take_damage(damage)
		_hit_sound.play()
		await get_tree().create_timer(0.05).timeout
	_destroy()
	
func _destroy():
	queue_free()
