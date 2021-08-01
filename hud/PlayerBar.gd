extends Control

var player: Player

func set_player(player: Player):
	self.player = player
	$HealthBar.attach(player.health)
