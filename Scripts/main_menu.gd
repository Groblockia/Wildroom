extends Control

@onready var startButton = $VBoxContainer/StartButton
@onready var optionsButton = $VBoxContainer/OptionsButton
@onready var quitButton = $VBoxContainer/StartButton

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/main.tscn")

func _on_options_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
