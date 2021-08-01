extends Area2D

var shooter
var retained_velocity = Vector2.ZERO
export var initial_speed = 400
export var initial_speed_spread = 5
onready var speed = rand_range(initial_speed - initial_speed_spread, initial_speed + initial_speed_spread)
export var damage = 1
export var pierce = 1
export var dampen_strength = 0.1
var pierce_count = 0

var destroyed = false

var direction = Vector2.RIGHT

func init(_shooter, initial_position, initial_rotation):
	if _shooter:
		if _shooter.velocity:
			retained_velocity = _shooter.velocity.normalized() * (_shooter.velocity.length() * 0.5)
	self.shooter = _shooter
	self.global_rotation = initial_rotation
	self.global_position = initial_position
	
	direction = Vector2.RIGHT.rotated(initial_rotation)

func _physics_process(delta):
	retained_velocity -= retained_velocity * delta
	var velocity = retained_velocity + direction * speed
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_entered():
	if not destroyed and $DespawnTimer:
		$DespawnTimer.stop()
func _on_VisibilityNotifier2D_screen_exited():
	if not destroyed and $DespawnTimer:
		$DespawnTimer.start()

func _on_DespawnTimer_timeout():
	destroy()
func _on_MaxLifespanTimer_timeout():
	destroy()

func _on_Bullet_body_entered(body):
	if not destroyed:
		if body.is_in_group("enemy"):
			if body.is_in_group("dampenable"):
				body.dampen(dampen_strength)
			body.damage(shooter, damage)
			pierce_count += 1
			if pierce_count > pierce:
				destroy()
			
func destroy():
	if not destroyed:
		destroyed = true
		queue_free()
