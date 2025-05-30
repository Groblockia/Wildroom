extends State

@export var falling_state : State
@export var idle_state : State
@export var moving_state : State

var previous_velocity_y : float

func enter():
	super()
	parent.state_label.text = str("Jumping_state")

func process_physics(delta):
	parent.velocity.y = parent.JUMP_VELOCITY
	return falling_state
		

	
