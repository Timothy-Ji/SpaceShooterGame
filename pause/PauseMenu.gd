extends MarginContainer

func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))

func _on_GithubLinkButton_pressed():
	OS.shell_open("https://github.com/Timothy-Ji/SpaceShooterGame")

func _on_PauseMenu_visibility_changed():
	if visible:
		$CenterContainer/VBoxContainer/VolumeControls/Slider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
