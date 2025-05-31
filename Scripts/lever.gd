extends Node3D

var leverstate = false

func toggle():
	if leverstate:
		$AnimationPlayer.play("lever_toggle_off")
	else:
		$AnimationPlayer.play("lever_toggle_on")
	leverstate = !leverstate
