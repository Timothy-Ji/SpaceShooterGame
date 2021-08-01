extends Node

onready var menu = $"../GUI/PauseMenu"

var paused = false

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		toggle()

func toggle():
	paused = !paused
	get_tree().paused = paused
	if paused:
		menu.show()
	else:
		menu.hide()
