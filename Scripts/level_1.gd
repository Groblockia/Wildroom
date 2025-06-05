extends Node3D

@onready var exit_door = $exit_door

var is_open = false

func _ready() -> void:
	Global.current_level = 1

func _process(_delta: float) -> void:
	#if rule is met:
	if Global.collectible_count >= 10:
		print("rule has been met")
		if !exit_door.is_open:
			exit_door.open()

func _on_checkpoint_collider_body_entered(body: Node3D) -> void:
	if body is Player:
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.start()
		timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Levels/Level2.tscn")
