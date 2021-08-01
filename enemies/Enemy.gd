extends KinematicBody2D

signal destroyed(source)
signal death_scene_triggered(death_scene)
signal damaged(source, amount)

export var speed = 100
export(PackedScene) var death_scene = null
var target = null

var destroyed = false
var velocity = Vector2.ZERO

var nearby_bodies = []
var drift_direction = Vector2.ZERO
export var drift_strength = 0.25

func move_toward_target(delta):
	if target:
		var target_pos = target.position
		var direction = position.direction_to(target_pos)
		
		var final_speed_modifier = speed * get_distance_speed_multipler()
		velocity += direction * final_speed_modifier * delta
		velocity = move_and_slide(velocity)
		velocity -= velocity * delta
		
func dampen(strength):
	velocity -= velocity * strength

func damage(source, amount):
	$Health.subtract(amount)
	emit_signal("damaged", source, amount)
	if $Health.get_value() == 0:
		kill(source)
	
func set_target(new_target):
	self.target = new_target
	
func kill(source):
	play_death_scene()
	destroyed = true
	emit_signal("destroyed", source)
	queue_free()

func get_distance_speed_multipler():
	if target:
		return max(1, log(position.distance_to(target.position) / 16) - 1)
	return 1

func play_death_scene():
	if death_scene:
		var instance = death_scene.instance()
		emit_signal("death_scene_triggered", instance)
		instance.init(self)
		instance.global_position = global_position
		get_tree().root.add_child(instance)

func _on_PersonalSpace_body_entered(body):
	nearby_bodies.append(body)

func _on_PersonalSpace_body_exited(body):
	nearby_bodies.erase(body)

var k = 0
func _process(_delta):
	k += 1
	if k == 5:
		k = 0
		update()

func _physics_process(delta):
	drift_direction = Vector2.ZERO
	for body in nearby_bodies:
		if body.is_in_group("enemy"):
			drift_direction -= position.direction_to(body.position)
	
	drift_direction = drift_direction
	velocity += drift_direction * (speed * drift_strength) * delta

func _draw():
#	var local_pos = to_local(position)
#	var local_pos_2 = to_local(position + drift_direction * 64)
#	draw_line(local_pos, local_pos_2, Color.red)
#	draw_circle_arc(local_pos, $PersonalSpace/CollisionShape2D.shape.radius, 0, 360, Color.blue)
	pass
	
func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
	
func to_local(position):
	return (position - global_position).rotated(-global_rotation)
