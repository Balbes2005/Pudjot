extends CharacterBody3D

var movement_speed: float = 10.0
var movement_target_position: Vector3  = $".".position

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	movement_target_position = $".".position
	print(movement_target_position)
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
