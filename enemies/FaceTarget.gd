extends Node2D

export var enabled = true

onready var parent = get_parent()
export(float, 0, 1) var rotation_speed = 1

func _physics_process(delta):
	if enabled and parent.target:
		var target_angle = parent.target.position.angle_to_point(parent.position)
		parent.rotation = lerp_angle(parent.rotation, target_angle, delta * 3)
