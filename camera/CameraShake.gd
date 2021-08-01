extends Node2D

signal trauma_added(amount)

func add_trauma(amount):	
	emit_signal("trauma_added", amount)
