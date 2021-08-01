extends Node2D

signal player_killed_enemy

export var max_enemies = 10
export var spawn_range = 100
var buffer_spawn_range = 16

var active_enemies = 0

var enemy_scene = preload("res://enemies/suicide_bomber/SuicideBomberEnemy.tscn")
var disabled = true
	
func set_disabled(value):
	disabled = value
	if disabled:
		$EnemySpawnTimer.stop()
	else:
		$EnemySpawnTimer.start()

func spawn():	
	var spawn_loc = generate_spawn_location()
	var new_enemy = enemy_scene.instance()
	new_enemy.set_target($"../Player")
	new_enemy.position = spawn_loc
	get_parent().add_child(new_enemy)
	active_enemies += 1
	new_enemy.connect("destroyed", self, "_on_Enemy_destroyed")
	new_enemy.connect("death_scene_triggered", self, "_on_Enemy_death_scene_triggered")
	pass

func generate_spawn_location():
	var player = $"../Player"
	var viewport = get_viewport_rect()
	var rad_x = viewport.size.x / 2 + buffer_spawn_range
	var rad_y = viewport.size.y / 2 + buffer_spawn_range
	
	var rad_px = rand_range(-rad_x - spawn_range, rad_x + spawn_range)
	var rad_py = 0
	if abs(rad_px) < viewport.size.x / 2:
		rad_py = rand_range(rad_y, rad_y + spawn_range)
		if (randi() % 2 == 0):
			rad_py = -rad_py
	else:
		rad_py = rand_range(-rad_y - spawn_range, rad_y + spawn_range)
		pass
		
	return Vector2(player.position.x + rad_px, player.position.y + rad_py)


func _on_EnemySpawnTimer_timeout():
	if active_enemies < max_enemies:
		spawn()
		
func _on_Enemy_destroyed(source):
	active_enemies -= 1
	if source is Node2D:
		if source.name == "Player":
			emit_signal("player_killed_enemy")

func _on_Enemy_death_scene_triggered(scene_instance):
	if scene_instance.is_in_group("camera_shake"):
		scene_instance.get_node("CameraShake").connect("trauma_added", self, "_on_trauma")

func _on_trauma(amount):
	var camera = $"../MainCamera"
	camera.add_shake(amount)
