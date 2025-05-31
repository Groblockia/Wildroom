extends Area3D
	

func _on_body_entered(_body: Node3D) -> void:
	Global.collectible_count += 1
	queue_free()

func _process(delta: float) -> void:
	$AnimationPlayer.play("collectible_bobbing")
	
