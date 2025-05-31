extends Node3D

func _process(_delta: float) -> void:
	$Label3D.text = "Collectibles: " + str(Global.collectible_count)
