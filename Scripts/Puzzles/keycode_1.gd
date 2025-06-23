extends Node3D

@onready var keypad = $Keypad
@onready var note = $Note

func _interact(namee):
	if namee == keypad.name:
		keypad_work()
	if namee == note.name:
		note_work()

func keypad_work():
	print("keypad used")

func note_work():
	print("note used")
