extends Node3D

signal lever_toggled_on
signal lever_toggled_off

var leverstate = false

func _ready() -> void:
	lever_toggled_on.connect(Global._lever_toggled_on)
	lever_toggled_off.connect(Global._lever_toggled_off)

func toggle():
	if leverstate:
		$AnimationPlayer.play("lever_toggle_off")
		lever_toggled_off.emit()
	else:
		$AnimationPlayer.play("lever_toggle_on")
		lever_toggled_on.emit()
	leverstate = !leverstate
