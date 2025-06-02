extends StaticBody3D


func _on_checkpoint_collider_body_entered(body: Node3D) -> void:
	print("zizi")
	if body is Player:
		print("caca")
