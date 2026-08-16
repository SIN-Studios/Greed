
extends Camera2D

@export var decay: float = 0.8
@export var max_offset: Vector2 = Vector2(50, 50)
@export var max_roll: float = 0.05               

var noise = FastNoiseLite.new()
var noise_y: float = 0.0
var trauma: float = 0.0
var trauma_power: int = 2



func _ready():
	randomize()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.05
	
	SignalManager.shake_requested.connect(add_trauma)


func _process(delta):
	if trauma > 0:
		trauma = max(trauma - decay * delta, 0)
		shake()
	else:
		offset = Vector2.ZERO
		rotation = 0

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1.0
	
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)

func add_trauma(amount: float):
	trauma = min(trauma + amount, 1.0)
