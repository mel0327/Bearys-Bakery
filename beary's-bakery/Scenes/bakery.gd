extends Node2D

@onready var music = $AudioStreamPlayer
@onready var loop_timer = $LoopTimer
var fade_duration := 1.5


func _input(event):
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			PauseMenu.resume()
		else:
			PauseMenu.pause()


func _ready() -> void:
	for node in get_tree().get_root().get_children():
		if node != self and node.has_node("AudioStreamPlayer"):
			node.get_node("AudioStreamPlayer").stop()
	music.volume_db = 0
	music.play()
	loop_timer.timeout.connect(_on_loop_timer_timeout)


func exit_tree():
	var tween := create_tween()
	tween.tween_property(music, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(music, "stop"))

func _on_loop_timer_timeout():
	music.play()
