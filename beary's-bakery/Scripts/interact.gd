extends Area2D


@onready var play_dialogue = preload("res://dialogue_2.tscn")

var is_player_near := false


func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		is_player_near = true
	)
	body_exited.connect(func (body: Node) -> void:
		is_player_near = false
	)


func _physics_process(_delta: float) -> void:
	if is_player_near and Input.is_action_just_pressed("interact"):
		var dialogue_instance = play_dialogue.instantiate()
		get_parent().add_child(dialogue_instance)
		set_deferred("monitoring", false)
