extends Popup
#gameplay
@onready var mouse_slider = $PanelContainer/MarginContainer/TabContainer/Gameplay/MarginContainer/VBoxContainer/MouseSensitivity/HSlider

#video
@onready var msaa = $PanelContainer/MarginContainer/TabContainer/Video/MarginContainer/VBoxContainer/MSAA/OptionButton
@onready var vsync_button = $PanelContainer/MarginContainer/TabContainer/Video/MarginContainer/VBoxContainer/Vsync/CheckButton
@onready var display_options = $PanelContainer/MarginContainer/TabContainer/Video/MarginContainer/VBoxContainer/DisplayOptions/OptionButton

#audio
@onready var master_slider = $PanelContainer/MarginContainer/TabContainer/Audio/MarginContainer/VBoxContainer/Master/HSlider

func _ready() -> void:
	##initialize the display
	display_options.select(1 if Save.game_data.fullscreen_on else 0)
	msaa.select(Save.game_data.msaa)
	vsync_button.button_pressed = Save.game_data.vsync_on
	mouse_slider.value = Save.game_data.mouse_sens
	master_slider.value = Save.game_data.master_vol
	# music_slider.value = Save.game_data.master_vol
	# sfx_slider.value = Save.game_data.master_vol
	# ambient_slider.value = Save.game_data.master_vol
	await get_tree().create_timer(0.001).timeout
	apply_settings()

#Vsync
func _on_CheckButton_toggled(button_pressed: bool):
	GlobalSettings.toggle_vsync(button_pressed)


# func _on_BrightnessSlider_value_changed(value):
# 	GlobalSettings.update_brightness(value)


func _on_MasterSlider_value_changed(value):
	GlobalSettings.update_master_vol(value)


# func _on_MusicSlider_value_changed(value):
# 	GlobalSettings.update_music_vol(value)


# func _on_SfxSlider_value_changed(value):
# 	GlobalSettings.update_sfx_vol(value)


# func _on_AmbientSlider_value_changed(value):
# 	GlobalSettings.update_ambient_vol(value)


#Mouse slider
func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	GlobalSettings.update_mouse_sens(mouse_slider.value)


#MSAA
func _on_option_button_item_selected(index: int) -> void:
	GlobalSettings.msaa_update(index)


#DisplayOptions
func _on_displayButton_item_selected(index: int) -> void:
	GlobalSettings.toggle_fullscreen(index)


func apply_settings():
	#display options
	_on_displayButton_item_selected(display_options.get_selected_id())
	#Mouse slider
	_on_h_slider_drag_ended(true)
	#MSAA
	_on_option_button_item_selected(msaa.get_selected_id())
	#Vsync
	_on_CheckButton_toggled(vsync_button.button_pressed)
