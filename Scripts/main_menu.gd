extends Control

@onready var startButton = $VBoxContainer/StartButton
@onready var optionsButton = $VBoxContainer/OptionsButton
@onready var quitButton = $VBoxContainer/StartButton



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var optMenu = Global.options_menu.instantiate()
	add_child(optMenu)
	await get_tree().create_timer(0.1).timeout
	optMenu.quit()
	Global.is_in_mainMenu = false

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/test.tscn")
	Global.is_in_mainMenu = false

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/options_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
