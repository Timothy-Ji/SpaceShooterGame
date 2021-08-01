extends "res://enemies/Enemy.gd"

export(PackedScene) var self_destruct_scene = null
export var dash_speed = 1000
export var dash_length = 0.5
export var dash_cd = 3
export var dampen_strength = 0.5
var dash_cd_time = 0

export var damage = 1

func _physics_process(delta):
	if dash_cd_time > 0:
		dash_cd_time -= delta
	elif randf() <= 0.05:
		modulate.g -= 0.5
		modulate.b -= 0.5
		dash_cd_time = dash_cd
		$DashRecoilReset.start(dash_length)
		
	if dash_cd_time > dash_cd - dash_length:
		velocity += velocity.normalized() * dash_speed * delta
		
	move_toward_target(delta)
		
	for i in get_slide_count():
		if not destroyed:
			var collision = get_slide_collision(i)
			if collision.collider.name == "Player":
				collision.collider.dampen(dampen_strength)
				collision.collider.damage(self, damage)
				self_destruct()
				
func self_destruct():
	if self_destruct_scene:
		death_scene = self_destruct_scene
	kill(self)

func _on_DashRecoilReset_timeout():
	modulate.g += 0.5
	modulate.b += 0.5
