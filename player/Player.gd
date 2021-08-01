class_name Player
extends KinematicBody2D

signal direction_changed(new_direction)

export var speed = 200
var velocity = Vector2.ZERO

onready var health: Hitpoints = $Health

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		$BulletSource.shoot(self, get_global_mouse_position())
		$BulletSource2.shoot(self, get_global_mouse_position())

func _physics_process(delta):
	# movement
	var movement = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	if Input.is_action_pressed("move_up"):
		movement.y -= 1
	
	movement = movement.normalized()
	
	if movement != Vector2.ZERO:
		velocity += movement * speed * delta
		emit_signal("direction_changed", movement)
	
	velocity = move_and_slide(velocity)
	velocity -= velocity * delta
	
	# face toward mouse
	var mouse_pos = get_local_mouse_position()
	rotation += mouse_pos.angle() * delta * 6

func dampen(strength):
	velocity -= velocity * strength
	
func damage(_source, amount):
	health.subtract(amount)
	if health.get_value() <= 0:
		kill()
		
func kill():
	var death = load("res://player/PlayerDeath.tscn")
	var death_inst = death.instance()
	death_inst.global_position = global_position
	get_tree().root.add_child(death_inst)
	queue_free()
