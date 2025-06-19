extends Control

@onready var settings_menu = $SettingsMenu
@onready var start_btn = $VBoxContainer/StartButton

func _ready():
	start_btn.grab_focus()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/test.tscn")
	#MusicManager.start_music(MusicManager.Intense1)


func _on_options_button_pressed() -> void:
	settings_menu.popup_centered()


func _on_quit_button_pressed() -> void:
	get_tree().quit()	
