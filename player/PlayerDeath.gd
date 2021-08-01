extends Node2D

signal add_shake(strength)

func _on_Timeout_timeout():
	queue_free()
