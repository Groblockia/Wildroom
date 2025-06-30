extends Area3D

var show_interaction_text = true

func _interact(_objName):
	position = Vector3(0,0,0)
	rotation = Vector3(0,0,0)
	$StaticBody3D.queue_free()
