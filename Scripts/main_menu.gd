extends Control

@onready var startButton = $VBoxContainer/StartButton
@onready var optionsButton = $VBoxContainer/OptionsButton
@onready var quitButton = $VBoxContainer/StartButton

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/test.tscn")
	Global.is_in_mainMenu = false

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/options_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
