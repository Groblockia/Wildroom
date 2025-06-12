extends State

@export var falling_state : State

var previous_velocity_y : float

func enter():
	super()

func process_physics(_delta):
	parent.velocity.y = parent.JUMP_VELOCITY
	return falling_state
		

	
