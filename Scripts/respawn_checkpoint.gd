extends Area3D


func _on_body_entered(body: Node3D) -> void:
	body.spawn_point = position
	queue_free()
