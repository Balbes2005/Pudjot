extends CharacterBody3D

var camera_speed: float = 20.0
var height_speed: float = 5.0
var wheel_speed: float = 2
var min_height:float = 7
var max_height:float = 14
var height:float = max_height
@onready var player = $"../PlayerBody"

func _ready():
	position.x = player.position.x 
	position.y = 0
	position.z = player.position.z + 5

func _physics_process(delta):
	var direction = Vector3(0,0,0)
	
	var edge_offset = 10;
	var screen_x_size = get_viewport().get_visible_rect().size.x
	var screen_y_size = get_viewport().get_visible_rect().size.y
	var mouse_position = get_viewport().get_mouse_position()
	var current_camera_position: Vector3 = position
	
	if Input.is_action_pressed('left_mouse_button'):
		print(screen_x_size)
		print(mouse_position.x)
	
	if(mouse_position.x < edge_offset):direction.x = -1
	if(mouse_position.x > screen_x_size - edge_offset):direction.x = 1
	if(mouse_position.y < edge_offset):direction.z = -1
	if(mouse_position.y > screen_y_size - edge_offset):direction.z = 1
	
	direction.y =current_camera_position.direction_to(Vector3(0,height + player.position.y,0)).y * height_speed
	velocity = direction * camera_speed
	
	move_and_slide()
	
	if(Input.is_action_just_pressed("mouse_wheel_down") && height < max_height): height = height + (wheel_speed)
	if(Input.is_action_just_pressed("mouse_wheel_up")&& height > min_height): height = height - (wheel_speed)
