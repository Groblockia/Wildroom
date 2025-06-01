extends Node3D

func _process(_delta: float) -> void:
	$Label3D.text = "Current rule is: " + str(Global.currentRule)
