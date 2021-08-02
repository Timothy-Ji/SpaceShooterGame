extends Node

signal game_over

var score = 0
var gameover = false

func _ready():
	$EnemyManager.set_disabled(false)
	$GUI/HUD/PlayerBar.set_player($Player)

func _on_restart_pressed():
	var _new_scene = get_tree().reload_current_scene()

func game_over():
	gameover = true
	$EnemyManager.set_disabled(true)	
	$GUI/GameOver.init(score)
	emit_signal("game_over")
	remove_child($Player)

func _on_Player_tree_exited():
	$MainCamera.add_shake(1)
	game_over()

func _on_EnemyManager_player_killed_enemy():
	score += 1
