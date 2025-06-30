extends Node3D

signal move_camera_to_screen(targetPos, targetOrientation)
signal exit_screen

@export var camera: Camera3D

const RAY_LENGTH = 1000

@onready var area
@onready var helper_pov = $helperPov
@onready var postit1mesh = $Postit1_initialPos/Postit1/MeshInstance3D
@onready var postit2mesh = $Postit2_initialPos/Postit2/MeshInstance3D

var clicked = false
var old_area

var show_interaction_text = true

func _ready() -> void:
	move_camera_to_screen.connect(Global._player_move_camera_to_screen)
	exit_screen.connect(Global._quit_screen)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("respawn"):
		_exit_screen()

func _physics_process(_delta: float) -> void:
	area = camera.raycast_draggable()
	
	if Input.is_action_just_pressed("clicGauche") && camera.raycast_draggable() != null : 
		old_area = area
		clicked = true
	
	if Input.is_action_pressed("clicGauche") && clicked && old_area.is_in_group("draggable"):
		var mouse_pos = get_viewport().get_mouse_position()
		var origin = camera.project_ray_origin(mouse_pos)
		var direction = camera.project_ray_normal(mouse_pos)
		
		var plane = Plane(transform.basis.z, transform.origin)
		var intersection = plane.intersects_ray(origin, direction)
		
		if intersection != null:
			old_area.global_position = intersection

	if Input.is_action_just_released("clicGauche"):
		clicked = false


func _interact(_objName):
	#print(objName)
	#print(-global_transform.basis.z)
	move_camera_to_screen.emit(helper_pov.global_position, helper_pov.global_rotation)
	show_interaction_text = false


func _exit_screen():
	exit_screen.emit()
	show_interaction_text = true


func _on_place_check_area_entered(_area: Area3D, extra_arg_0: StringName) -> void:
	if extra_arg_0 == "PlaceCheck1" && area.name == "Postit1":
		postit_in_correct_place(postit1mesh)
	if extra_arg_0 == "PlaceCheck2" && area.name == "Postit2":
		postit_in_correct_place(postit2mesh)

func _on_place_check_area_exited(_area: Area3D, extra_arg_0: StringName) -> void:
	if extra_arg_0 == "PlaceCheck1" && area.name == "Postit1":
		postit_not_in_correct_place(postit1mesh)
	if extra_arg_0 == "PlaceCheck2" && area.name == "Postit2":
		postit_not_in_correct_place(postit2mesh)


func postit_in_correct_place(postit):
	postit.mesh.material.albedo_color = Color8(171, 255, 171, 1)

func postit_not_in_correct_place(postit):
	postit.mesh.material.albedo_color = Color8(255, 255, 255, 1)
