extends Node

@onready var options_menu = preload("res://Menus/options_menu.tscn")

var options = preload("res://Menus/options_menu.tscn")
var is_in_mainMenu = true
var is_in_optionsMenu = false

var mouse_sensitivity 
