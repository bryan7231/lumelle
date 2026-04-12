@tool
extends Node3D

@export var generate_now: bool = false:
	set(value):
		if value == true:
			generate_collisions()
			generate_now = false

func generate_collisions():
	for child in get_children():
		var mesh = child.get_child(0) 
		if mesh is MeshInstance3D:
			mesh = mesh as MeshInstance3D
			if not has_collision_child(mesh):
				mesh.create_convex_collision()

func has_collision_child(node: Node) -> bool:
	for child in node.get_children():
		if child is StaticBody3D:
			return true
	return false
		
