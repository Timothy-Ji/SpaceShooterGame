extends Node2D

export(float) var orbit_spread = 0.001
export(float, 0, 1) var death_camera_shake = 0.2

func _ready():
	randomize()
	$BlueParticles.orbit_velocity = rand_range(-orbit_spread, orbit_spread)
	$RedParticles.orbit_velocity = rand_range(-orbit_spread, orbit_spread)
	$GrayParticles.orbit_velocity = rand_range(-orbit_spread, orbit_spread)
	$BlueParticles.emitting = true
	$RedParticles.emitting = true
	$RedParticles.emitting = true
	$AnimationPlayer.play("fade")

func init(enemy):
	var direction = Vector2.LEFT.rotated(enemy.rotation)
	$BlueParticles.gravity = direction
	$RedParticles.gravity = direction
	$GrayParticles.gravity = direction
	$CameraShake.add_trauma(death_camera_shake)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		queue_free()
