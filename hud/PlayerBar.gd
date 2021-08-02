extends Control

var player: Player

func _process(delta):
	if player:
		$PlayerSprite.rect_rotation = rad2deg(player.rotation)

func set_player(player: Player):
	self.player = player
	$HealthBar.attach(player.health)
