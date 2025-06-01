extends Area3D

signal collectible_collected

func _ready() -> void:
	collectible_collected.connect(Global._collectible_collected)

func _on_body_entered(_body: Node3D) -> void:
	collectible_collected.emit()
	queue_free()

func _process(_delta: float) -> void:
	$AnimationPlayer.play("collectible_bobbing")
	
