extends MarginContainer

signal volume_slider_value_changed(value)

func _on_VolumeSlider_value_changed(value):
	emit_signal("volume_slider_value_changed", value)
