extends ProgressBar

var health: Hitpoints

func _on_health_changed(_sender, new_health, _difference):
	value = new_health
	
func _on_max_health_changed(_sender, new_max_health):
	max_value = new_max_health

func attach(health):
	if self.health:
		self.health.disconnect("changed", self, "_on_health_changed")
		self.health.disconnect("max_changed", self, "_on_max_health_changed")
	self.health = health
	health.connect("changed", self, "_on_health_changed")
	health.connect("max_changed", self, "_on_max_health_changed")
	value = health.get_value()
	max_value = health.get_max()
