extends ProgressBar

export(NodePath) var tracking = null

var health: Hitpoints

func _ready():
	health = get_node(tracking).get_node("Health")
	value = health.get_hp()
	max_value = health.get_max_hp()
	health.connect("changed", self, "_on_Player_health_changed")

func _on_Player_health_changed(_sender, new_health, _difference):
	value = new_health
