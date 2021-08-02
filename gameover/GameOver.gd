extends MarginContainer

signal restart_pressed

func init(final_score):
	show()
	$Menu/VBoxContainer/ScoreLabel.text = "Score: " + str(final_score)
	$FadeIn.play("fade_in")

func _on_Restart_pressed():
	emit_signal("restart_pressed")
