extends CanvasLayer

@onready var music = $AudioStreamPlayer
var fade_duration := 0.5

func _ready() -> void:
	music.volume_db = 0
	music.play()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func exit_tree():
	var tween := create_tween()
	tween.tween_property(music, "volume_db", -80, fade_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(Callable(music, "stop"))

func _on_loop_timer_timeout():
	music.play()
