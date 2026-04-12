extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var sensitivity = 0.005
@export var smoothness = 20
var target_rotation_x = 0.0
var target_rotation_y = 0.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_rotation_y -= event.relative.x * sensitivity
		target_rotation_x -= event.relative.y * sensitivity
		target_rotation_x = clamp(target_rotation_x, deg_to_rad(-40), deg_to_rad(60))

func _process(delta):
	head.quaternion = head.quaternion.slerp(Quaternion(Vector3.UP, target_rotation_y), smoothness * delta)
	
	camera.rotation.x = lerp(head.rotation.x, target_rotation_x, smoothness * delta)
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 3.0)
		
	
	move_and_slide()
