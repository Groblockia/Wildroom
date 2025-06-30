extends Camera3D

const RAY_LENGTH = 1000

func raycast_draggable():
	var space_state = get_world_3d().direct_space_state
	var cam = self
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.global_position
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	result = result.get("collider")
	return result
