extends Node

@onready var Intense1 = $Intense1
@onready var Intense2 = $Intense2
@onready var Intense3 = $Intense3
@onready var Suspense = $Suspense

func _ready() -> void:
	pass


func start_music(music):
	music.play()


func stop_music(music):
	music.stop()


func crossfade(current_music:AudioStreamPlayer2D, target_music:AudioStreamPlayer2D, duration := 4.0):
	var tween = get_tree().create_tween()
	target_music.volume_linear = 0
	target_music.play()
	
	tween.tween_property(current_music, "volume_linear", 0.2, duration)
	tween.tween_property(target_music, "volume_linear", 1, duration)

	tween.tween_callback(current_music.stop)
