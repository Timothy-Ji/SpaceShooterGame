extends ParallaxBackground

export var drift_multiplier = 5
onready var scroll = Vector2.ONE.normalized() * drift_multiplier

func _process(delta):
	scroll_base_offset += scroll * delta

func _on_Player_direction_changed(velocity):
	var direction = velocity.normalized()
	scroll = -direction * drift_multiplier
