extends StaticBody3D

var is_open = false

signal exit_checkpoint_passed

func _ready() -> void:
	exit_checkpoint_passed.connect(Global._exit_checkpoint_passed)

func _on_checkpoint_collider_body_entered(body: Node3D) -> void:
	if body is Player:
		exit_checkpoint_passed.emit()

func open():
	$AnimationPlayer.play("door_opnening")

func close():
	$AnimationPlayer.play("door_closing")
