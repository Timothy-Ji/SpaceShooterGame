extends MarginContainer

signal volume_slider_value_changed(value)

func _on_VolumeSlider_value_changed(value):
	emit_signal("volume_slider_value_changed", value)


func _on_GithubLinkButton_pressed():
	OS.shell_open("https://github.com/Timothy-Ji/SpaceShooterGame")
