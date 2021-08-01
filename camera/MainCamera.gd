# camera shake from kidscancode.org
extends Camera2D

onready var target = $"../Player"
export(float, 0, 1) var shake_decay = 0.5
export(Vector2) var shake_max_offset = Vector2(32, 32)
export(float, 0, 0.5) var shake_max_roll = 0.1
var trauma = 0.1
var trauma_pow = 2
onready var noise = OpenSimplexNoise.new()
var noise_y = 0

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 5
	noise.octaves = 2
	
func _process(delta):
	if target:
		global_position = target.global_position
	if trauma:
		trauma = max(trauma - shake_decay * delta, 0)
		shake()

func add_shake(amount):
	trauma = min(trauma + amount, 1.0)
	
func shake():
	var amount = pow(trauma, trauma_pow)
	noise_y += 1
	rotation = shake_max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = shake_max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = shake_max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)
