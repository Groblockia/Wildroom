extends Control

@onready var mouse_sensitivity_button = $PanelContainer/MarginContainer/VBoxContainer/MouseSensitivity_button/HSlider
@onready var msaa = $PanelContainer/MarginContainer/VBoxContainer/MSAA_button/OptionButton
@onready var back_button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Back_button
@onready var mainMenu_button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MainMenu_button

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Global.is_in_optionsMenu = true
	if Global.is_in_mainMenu:
		mainMenu_button.visible = false
	else:
		mainMenu_button.visible = true
	get_settings()

func _process(_delta: float) -> void:
	#print(Global.mouse_sensitivity)
	mouse_sensitivity_selection()
	msaa_selection()


	if Input.is_action_just_pressed("esc"):
		call_deferred("_on_back_button_pressed")

func msaa_selection():
	if msaa.selected == 0:
		pass

func mouse_sensitivity_selection():
	Global.mouse_sensitivity = mouse_sensitivity_button.value/1000


func _on_back_button_pressed() -> void:
	set_settings()
	if !Global.is_in_mainMenu:
		queue_free()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Global.is_in_optionsMenu = false
	else:
		get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
		Global.is_in_optionsMenu = false


func _on_main_menu_button_pressed() -> void:
	Global.is_in_optionsMenu = false
	Global.is_in_mainMenu = true
	queue_free()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	set_settings()

func get_settings():
	mouse_sensitivity_button.value = Options.mouse_sensitivity
	msaa.selected = Options.msaa

func set_settings():
	Options.mouse_sensitivity = mouse_sensitivity_button.value
	Options.msaa = msaa.selected
