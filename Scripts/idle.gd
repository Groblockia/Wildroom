extends State

@export var moving_state : State
@export var jumping_state : State
@export var falling_state : State

func enter() -> void:
	super()
	parent.state_label.text = str("Idle_state")

func process_physics(delta):
	
	parent.velocity.x = lerp(parent.velocity.x, 0.0, delta * parent.DECCELERATION_SPEED)
	parent.velocity.z = lerp(parent.velocity.z, 0.0, delta * parent.DECCELERATION_SPEED)
	parent.move_and_slide()

	#if in the air:
	if !parent.is_on_floor():
		print("rentrer en falling_state")
		return falling_state

	#if trying to jump
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		print("passage a jumping_state")
		return jumping_state
	
	#if trying to move
	if Input.get_vector("forward", "backward", "left", "right") != Vector2.ZERO:
		print("passage a moving_state")
		return moving_state
	
