extends Control

@onready var startButton = $VBoxContainer/StartButton
@onready var optionsButton = $VBoxContainer/OptionsButton
@onready var quitButton = $VBoxContainer/StartButton

signal start_button
signal options_button
signal quit_button

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Main.tscn")

func _on_options_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
