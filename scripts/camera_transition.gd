extends Node

@onready var camera2D: Camera2D = $Camera2D
@onready var camera3D: Camera3D = $Camera3D

var tween: Tween = null
var transitioning: bool = false

func transition_camera2D(from: Camera2D, to: Camera2D, duration: float = 1.0) -> void:
	if transitioning: return
	# Copy parameters of first cam
	camera2D.zoom = from.zoom
	camera2D.offset = from.offset
	camera2D.light_mask = from.light_mask
	
	# Move transition camera to first camera pos
	camera2D.global_transform = from.global_transform
	
	# Make our transition camera current
	camera2D.make_current()
	
	transitioning = true
	
	# Move to the second camera, while also adjusting the parameters 
	# to match the second camera
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(camera2D, "global_transform", to.global_transform, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera2D, "zoom", to.zoom, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera2D, "offset", to.offset, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	# Wait for screen to complete
	await tween.finished
	
	# Make the second camera current
	to.make_current()
	transitioning = false

func transition_camera3D(from: Camera3D, to: Camera3D, duration: float = 1.0) -> void:
	if transitioning: return
	
	# Copy the parameters of first camera
	camera3D.fov = from.fov
	camera3D.cull_mask = from.cull_mask
	
	# Move our transition camera to the first camera position
	camera3D.global_transform = from.global_transform
	
	# Make our transition camera current
	camera3D.make_current()
	
	transitioning = true
	
	# Move to the second camera while also adjusting parameters to match the second camera
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(camera3D, "global_transform", to.global_transform, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera3D, "fov", to.fov, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	# Wait for completion
	await tween.finished
	
	# Make the second camera current
	to.make_current()
	transitioning = false
	
	
	
