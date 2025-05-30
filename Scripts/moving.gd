extends State

@export var jumping_state : State
@export var falling_state : State
@export var idle_state : State

func enter():
	super()
	parent.state_label.text = str("Moving_state")

func process_physics(delta):
	parent.velocity.x = lerp(parent.velocity.x, parent.direction.x * parent.SPEED, delta * parent.ACCELERATION_SPEED)
	parent.velocity.z = lerp(parent.velocity.z, parent.direction.z * parent.SPEED, delta * parent.ACCELERATION_SPEED)
	parent.move_and_slide()

	#if in the air
	if !parent.is_on_floor():
		print("rentrer en falling_state")
		return falling_state
	
	#if no movement
	if Input.get_vector("forward", "backward", "left", "right") == Vector2.ZERO:
		return idle_state
	
	#if trying to jump
	if Input.is_action_just_pressed("jump"):
		return jumping_state
	
