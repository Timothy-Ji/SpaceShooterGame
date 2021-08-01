extends Node2D

export(PackedScene) var projectile = null
export var fire_rate = 10
var fire_cd = 0
export(float, 0, 1) var spread = 0.05

var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()

func _process(delta):
	if fire_cd > 0:
		fire_cd -= delta

func shoot(shooter, target_position):
	if fire_cd <= 0:
		var new_projectile = projectile.instance()
		
		var target_angle = target_position.angle_to_point(global_position)
		
		new_projectile.init(shooter, global_position, rand.randfn(target_angle, spread))
		
		get_tree().root.add_child(new_projectile)
		fire_cd = 1.0/fire_rate + rand_range(-1.0/fire_rate * 0.1, 1.0/fire_rate * 0.1)
