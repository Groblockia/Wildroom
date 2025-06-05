extends StaticBody3D

var is_open = false

func open():
	$AnimationPlayer.play("door_opnening")
	is_open = true

func close():
	$AnimationPlayer.play("door_closing")
	is_open = false
