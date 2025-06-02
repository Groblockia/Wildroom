extends Node

var collectible_count = 0
var interactible_count = 0

var passed_exit = false

var validation_sound = preload("res://Assets/Wildroom__Validation-Sound__Draft-02__Render-01.mp3")
var reprobation_sound = preload("res://Assets/Wildroom__Reprobation-Sound__Draft-01__Render-01.mp3")

var validationSoundPlayer = AudioStreamPlayer.new()
var reprobationSoundPlayer = AudioStreamPlayer.new()

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
		if collectible_count == 10:
			#open the door, and do the two following lines once player has passed it
			currentRule = 2
			_new_room()
	#rule 2 check:
	if currentRule == 2:
		if interactible_count == 5:
			currentRule = 3
			_new_room()

	#DEBUG
	if Input.is_action_just_pressed("rule1"):
		currentRule = 1
		_new_room()
	if Input.is_action_just_pressed("rule2"):
		currentRule = 2
		_new_room()

##signals management
#plays each time player enters a new room
func _new_room():
	collectible_count = 0
	interactible_count = 0

func _collectible_collected():
	collectible_count += 1
	if currentRule == 1:
		validationSoundPlayer.play()

func _lever_toggled_on():
	interactible_count += 1
	if currentRule == 2:
		validationSoundPlayer.play()

func _lever_toggled_off():
	interactible_count -= 1
	if currentRule == 2:
		reprobationSoundPlayer.play()
		
