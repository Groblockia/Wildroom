extends State

@export var idle_state : State
@export var moving_state : State

func enter():
	super()
	parent.state_label.text = str("Falling_state")

func process_physics(delta):
	parent.velocity.y -= gravity * delta
	parent.velocity.x = lerp(parent.velocity.x, parent.direction.x * parent.SPEED, delta * parent.AIR_DECCELERATION_SPEED)
	parent.velocity.z = lerp(parent.velocity.z, parent.direction.z * parent.SPEED, delta * parent.AIR_DECCELERATION_SPEED)
	parent.move_and_slide()

	if parent.is_on_floor():
		#if trying to move:
		if Input.get_vector("forward", "backward", "left", "right") != Vector2.ZERO:
			return moving_state
		else:
			return idle_state
