class_name State
extends Node

@export var move_speed: float = 300

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent):
	return null

func process_physics(delta: float):
	return null

func process_frame(delta: float):
	return null
