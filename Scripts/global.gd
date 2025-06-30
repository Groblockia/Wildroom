extends Node

signal player_move_camera_to_screen(targetPos, targetOrientation)
signal quit_screen


@onready var options_menu = preload("res://Menus/settings_Menu.tscn")

func _ready() -> void:
	pass
##signal management

func _player_move_camera_to_screen(targetPos, targetOrientation):
	player_move_camera_to_screen.emit(targetPos, targetOrientation)

func _quit_screen():
	quit_screen.emit()
