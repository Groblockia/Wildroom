extends Node

var options = preload("res://Menus/options_menu.tscn")
var is_in_mainMenu = true
var is_in_optionsMenu = false

var mouse_sensitivity = 0.001

func _ready() -> void:
	print("caca")

func spawn_scene(scene: Resource):
	var temp = scene.instantiate()
	add_child(temp)
