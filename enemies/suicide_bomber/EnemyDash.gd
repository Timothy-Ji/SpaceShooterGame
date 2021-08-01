extends Node2D

func _ready():
	$CPUParticles2D.emitting = true

func _on_LifespanTimer_timeout():
	queue_free()
