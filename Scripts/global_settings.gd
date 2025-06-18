extends Node

signal mouse_sens_updated(value)

func toggle_fullscreen(toggle: bool):
	if toggle:
		print("fullscreen")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		print("windowed")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	Save.game_data.fullscreen_on = toggle
	Save.save_data()


func toggle_vsync(toggle):
	if toggle:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	Save.game_data.vsync_on = toggle
	Save.save_data()


func update_mouse_sens(value):
	emit_signal("mouse_sens_updated", value)
	Save.game_data.mouse_sens = value
	Save.save_data()


func msaa_update(i):
	Save.game_data.msaa = i
	if i == 0:
		RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
	elif i == 1:
		RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
	elif i == 2:
		RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_4X)
	elif i == 3:
		RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_8X)
	Save.save_data()


func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, linear_to_db(vol))
	Save.game_data.master_vol = vol
	Save.save_data()


# func update_music_vol(vol):
# 	AudioServer.set_bus_volume_db(1, linear_to_db(vol))


# func update_sfx_vol(vol):
# 	AudioServer.set_bus_volume_db(2, linear_to_db(vol))


# func update_ambient_vol(vol):
# 	AudioServer.set_bus_volume_db(3, linear_to_db(vol))
