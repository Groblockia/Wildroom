extends Node

const SAVEFILE = "SAVEFILE.txt"

@onready var game_data = {}

func _ready():
	load_data()

func load_data():
	print("load_data called")
	var file
	if not FileAccess.file_exists(SAVEFILE):
		game_data = {
			"fullscreen_on": false,
			"vsync_on": true,
			"msaa" : 3,
			"master_vol": 1,
			"music_vol": 1,
			"sfx_vol": 1,
			"ambient_vol": 1,
			"mouse_sens": 2.5,
		}
		save_data()
	file = FileAccess.open(SAVEFILE, FileAccess.READ)
	game_data = file.get_var()
	file.close()

func save_data():
	print("save_data called")
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(game_data)
	file.close()
