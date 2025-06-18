class_name Player
extends CharacterBody3D

@export var ACCELERATION_SPEED = 2
@export var DECCELERATION_SPEED = 2
@export var AIR_DECCELERATION_SPEED = 1
@export var JUMP_VELOCITY = 5
@export var SPEED = 4

@onready var state_machine = $StateMachine
@onready var camera = $camera_pivot/Camera3D
@onready var camera_pivot = $camera_pivot
@onready var raycast = $camera_pivot/Camera3D/RayCast3D

var input_dir : Vector2
var direction :Vector3

var rot_x = 0.0 # horizontal
var rot_y = 0.0 # vertical

const MAX_VERTICAL_ANGLE = deg_to_rad(89)

var mouse_sensitivity

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	state_machine.init(self)
	GlobalSettings.mouse_sens_updated.connect(_update_mouse_sens)
	print("mouse_sensi = ", mouse_sensitivity)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

	#camera movement
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rot_x += event.relative.x * mouse_sensitivity
		rot_y += event.relative.y * mouse_sensitivity
		rot_y = clamp(rot_y, -MAX_VERTICAL_ANGLE, MAX_VERTICAL_ANGLE)

		# Rotation horizontale sur le Player
		rotation.y = -rot_x

		# Rotation verticale sur la tête
		camera_pivot.rotation.x = -rot_y


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

	#player movement
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func _process(delta):
	state_machine.process_frame(delta)

	if Input.is_action_just_pressed("interact"): interact()

	#DEBUG
	if Input.is_action_just_pressed("mouse_tab"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func interact():
	var obj = raycast.get_collider()

	if obj == null:
		pass
	elif obj.is_in_group("lever"):
		obj.toggle()


func _update_mouse_sens(value):
	mouse_sensitivity = value/1000
