class_name Player
extends CharacterBody3D

signal interacted

const MAX_VERTICAL_ANGLE = deg_to_rad(89)

@export var ACCELERATION_SPEED = 2
@export var DECCELERATION_SPEED = 2
@export var AIR_DECCELERATION_SPEED = 1
@export var JUMP_VELOCITY = 5
@export var SPEED = 4

@onready var state_machine = $StateMachine
@onready var camera = $camera_pivot/Camera3D
@onready var camera_pivot = $camera_pivot
@onready var raycast = $camera_pivot/Camera3D/RayCast3D
@onready var hint_label = $camera_pivot/Camera3D/UI/HintLabel

@onready var defaultCameraPosition = camera.position
@onready var defaultCameraRotation = camera.rotation

var input_dir : Vector2
var direction :Vector3

var rot_x = 0.0 # horizontal
var rot_y = 0.0 # vertical

var mouse_sensitivity
var spawn_point
var interacting = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	state_machine.init(self)
	GlobalSettings.mouse_sens_updated.connect(_update_mouse_sens)
	Global.player_move_camera_to_screen.connect(move_camera_to_target)
	Global.quit_screen.connect(reset_camera)


func _unhandled_input(event: InputEvent) -> void:
	if !interacting:
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
	if !interacting:
		state_machine.process_physics(delta)

		#player movement
		input_dir = Input.get_vector("left", "right", "forward", "backward")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func _process(delta):
	hint_label.text = ""
	if !interacting:
		state_machine.process_frame(delta)
		interact()

		if Input.is_action_just_pressed("mouse_tab"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func interact():
	var obj = raycast.get_collider()
	
	if obj == null:
		pass
	else:
		if obj.get_parent().show_interaction_text:
			hint_label.text = "Press 'E' to interact"
		if Input.is_action_just_pressed("interact"):
			interacted.connect(obj.get_parent()._interact)
			interacted.emit(obj.name)
			interacted.disconnect(obj.get_parent()._interact)


func _update_mouse_sens(value):
	mouse_sensitivity = value/1000


func respawn():
	position = spawn_point


func show_text():
	pass


func move_camera_to_target(targetPos,targetOrientation):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	interacting = true
	var tween = get_tree().create_tween()
	tween.set_parallel()

	tween.tween_property(camera, "global_position", targetPos, 0.5)
	tween.tween_property(camera, "global_rotation", targetOrientation, 0.5)
	

func reset_camera():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var tween = get_tree().create_tween()
	tween.set_parallel()

	tween.tween_property(camera, "position", defaultCameraPosition, 0.5)
	tween.tween_property(camera, "rotation", defaultCameraRotation, 0.5)
	await tween.finished
	interacting = false 
