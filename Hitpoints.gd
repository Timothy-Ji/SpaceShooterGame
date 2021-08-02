class_name Hitpoints
extends Node

signal changed(this, new_value, difference)
signal max_changed(this, new_value)

export var hp = 10
export var max_hp = 10
export var allow_overflow = false
export var allow_underflow = false

func set_value(new_value):
	var old = hp
	hp = new_value
	if hp < 0 and not allow_underflow:
		hp = 0
	elif hp > max_hp and not allow_overflow:
		hp = max_hp
	emit_signal("changed", self, new_value, new_value - old)	
	
func subtract(value):
	hp -= value
	if hp < 0 and not allow_underflow:
		hp = 0
	elif hp > max_hp and not allow_overflow:
		hp = max_hp
	emit_signal("changed", self, hp, -value)
	
func add(value):
	hp += value
	if hp < 0 and not allow_underflow:
		hp = 0
	elif hp > max_hp and not allow_overflow:
		hp = max_hp
	emit_signal("changed", self, hp, value)
		
func set_max(new_max_hp):
	emit_signal("max_changed", self, new_max_hp)
	max_hp = new_max_hp
	
func get_value():
	return hp

func get_max():
	return max_hp
