extends Control

var is_paused = false : set = set_paused

@onready var settings_menu = $SettingsMenu

func _ready():
	hide()


func set_paused(value):
	is_paused = value
	get_tree().paused = value
	visible = is_paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		self.is_paused = !is_paused


func _on_resume_button_pressed() -> void:
	self.is_paused = false


func _on_settings_button_pressed() -> void:
	settings_menu.popup_centered()

	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
