extends Control

@onready var mouse_sensitivity_button = $PanelContainer/MarginContainer/VBoxContainer/MouseSensitivity_button/HSlider
@onready var msaa = $PanelContainer/MarginContainer/VBoxContainer/MSAA_button/OptionButton
@onready var back_button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Back_button
@onready var mainMenu_button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MainMenu_button
@onready var vsync_button = $PanelContainer/MarginContainer/VBoxContainer/Vsync_button/CheckButton

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Global.is_in_optionsMenu = true
	if Global.is_in_mainMenu:
		mainMenu_button.visible = false
	else:
		mainMenu_button.visible = true
		get_tree().paused = true
	get_settings()
	

func _process(_delta: float) -> void:
	#print(Global.mouse_sensitivity)
	mouse_sensitivity_selection()
	msaa_selection()
	vsync_toggle()

	if Input.is_action_just_pressed("esc"):
		call_deferred("_on_back_button_pressed")

func mouse_sensitivity_selection():
	Global.mouse_sensitivity = mouse_sensitivity_button.value/1000

func msaa_selection():
	var x = msaa.get_selected_id()
	match x: 
		0:
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
		1:
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
		2:
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_4X)
		3:
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_8X)

func vsync_toggle():
	if vsync_button.button_pressed:	
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func get_settings():
	mouse_sensitivity_button.value = Options.mouse_sensitivity
	msaa.selected = Options.msaa
	vsync_button.button_pressed = Options.vsync_button

func set_settings():
	Options.mouse_sensitivity = mouse_sensitivity_button.value
	Options.msaa = msaa.selected
	Options.vsync_button = vsync_button.button_pressed

func _on_back_button_pressed() -> void:
	get_tree().paused = false
	Global.is_in_optionsMenu = false
	set_settings()
	if !Global.is_in_mainMenu:
		queue_free()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	Global.is_in_optionsMenu = false
	Global.is_in_mainMenu = true
	queue_free()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	set_settings()

func quit():
	Global.is_in_optionsMenu = false
	queue_free()
