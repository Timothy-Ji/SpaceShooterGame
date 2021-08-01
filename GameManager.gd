extends Node

signal game_over

var score = 0
var gameover = false

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(0.8))	
	$EnemyManager.set_disabled(false)

func _on_restart_pressed():
	var _new_scene = get_tree().reload_current_scene()

func game_over():
	gameover = true
	$EnemyManager.set_disabled(true)	
	remove_child($Player)
	$GUI/GameOver.init(score)
	emit_signal("game_over")

func _on_Player_tree_exited():
	$MainCamera.add_shake(1)
	game_over()

func _on_EnemyManager_player_killed_enemy():
	score += 1

func _on_volume_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))
