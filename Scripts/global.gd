extends Node

var collectible_count = 0
var interactible_count = 0

var passed_exit = false

var validation_sound = preload("res://Assets/Wildroom__Validation-Sound__Draft-02__Render-01.mp3")
var reprobation_sound = preload("res://Assets/Wildroom__Reprobation-Sound__Draft-01__Render-01.mp3")

var validationSoundPlayer = AudioStreamPlayer.new()
var reprobationSoundPlayer = AudioStreamPlayer.new()

var rule_is_met = false

var current_level = 1

func _ready() -> void:
	validationSoundPlayer.stream = validation_sound
	add_child(validationSoundPlayer)
	reprobationSoundPlayer.stream = reprobation_sound
	add_child(reprobationSoundPlayer)

##signals management

#plays each time player enters a new room
func _new_room():
	collectible_count = 0
	interactible_count = 0

func _collectible_collected():
	collectible_count += 1
	if current_level == 1 && !rule_is_met:
		print("sound played")
		validationSoundPlayer.play()

func _lever_toggled_on():
	interactible_count += 1
	if current_level == 2 && !rule_is_met:
		validationSoundPlayer.play()

func _lever_toggled_off():
	interactible_count -= 1
	if current_level == 2 && !rule_is_met:
		reprobationSoundPlayer.play()
