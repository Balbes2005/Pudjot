extends Camera3D

@onready var camera = $"."
@onready var player = $"../../PlayerBody"

var rayOrigin = Vector3()
var rayEnd = Vector3()



func _physics_process(delta):
	
	if Input.is_action_pressed('right_mouse_button'):
		set_movement_target_for_player()
		
	if(Input.is_action_just_pressed('escape')):
		get_tree().quit()
	
func set_movement_target_for_player():
	var space_state = camera.get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	rayOrigin = camera.project_ray_origin(mouse_position)
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 1000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd)
	var result = space_state.intersect_ray(query)
	if(result.size() > 0):
		print(result)
		player.set_movement_target(result.position)
