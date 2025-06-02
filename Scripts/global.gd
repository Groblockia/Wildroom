extends Node

var collectible_count = 0
var interactible_count = 0

var passed_exit = false

var validation_sound = preload("res://Assets/Wildroom__Validation-Sound__Draft-02__Render-01.mp3")
var reprobation_sound = preload("res://Assets/Wildroom__Reprobation-Sound__Draft-01__Render-01.mp3")

var validationSoundPlayer = AudioStreamPlayer.new()
var reprobationSoundPlayer = AudioStreamPlayer.new()

var rule_is_met = false
var currentRule = 1
#Rule 1: Must collect all the collectibles (10) to open the door. good sound when collectible collected
#Rule 2: Must turn on all the levers (5) to open the door. good sound when turned on, bad soun when turned off

func _ready() -> void:
	validationSoundPlayer.stream = validation_sound
	add_child(validationSoundPlayer)
	reprobationSoundPlayer.stream = reprobation_sound
	add_child(reprobationSoundPlayer)

func _process(_delta: float) -> void:
	#rule 1 check:
	if currentRule == 1:
		if collectible_count >= 10:
			rule_is_met = true
			open_door("door1")
			#once player passes checkpoint:
			if passed_exit == true:
				_new_room()
				currentRule = 2
				rule_is_met = false
				passed_exit = false
				close_door("door1")
				
	#rule 2 check:
	if currentRule == 2:
		if interactible_count >= 5:
			rule_is_met = true
			open_door("door2")
			#once player passes checkpoint:
			if passed_exit == true:
				_new_room()
				currentRule = 3
				rule_is_met = false
				passed_exit = false
				close_door("door2")

func open_door(door:String):
	for node in get_tree().get_nodes_in_group(door):
		if node.is_open == false:
			node.open()
			node.is_open = true

func close_door(door:String):
	for node in get_tree().get_nodes_in_group(door):
		if node.is_open == true:
			node.close()
			node.is_open = false

##signals management

#plays each time player enters a new room
func _new_room():
	collectible_count = 0
	interactible_count = 0

func _collectible_collected():
	collectible_count += 1
	if currentRule == 1 && !rule_is_met:
		validationSoundPlayer.play()

func _lever_toggled_on():
	interactible_count += 1
	if currentRule == 2 && !rule_is_met:
		validationSoundPlayer.play()

func _lever_toggled_off():
	interactible_count -= 1
	if currentRule == 2 && !rule_is_met:
		reprobationSoundPlayer.play()
		
func _exit_checkpoint_passed():
	passed_exit = true
