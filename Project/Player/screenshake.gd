extends Camera2D

@export var decay: float = 0.8                   
@export var max_offset: Vector2 = Vector2(30, 30) 
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
	
	if SignalManager.shake_requested:
		SignalManager.shake_requested.connect(add_trauma)

func _process(delta):
	if trauma > 0.0:
		trauma = max(trauma - decay * delta, 0.0)
		shake(delta)
	else:
		offset = Vector2.ZERO
		rotation = 0.0

func shake(delta):
	var amount = pow(trauma, trauma_power)
	noise_y += delta * 60.0 
	
	var target_rot = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	var target_offset_x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	var target_offset_y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)
	
	if is_finite(target_rot) and is_finite(target_offset_x) and is_finite(target_offset_y):
		rotation = target_rot
		offset.x = target_offset_x
		offset.y = target_offset_y

func add_trauma(amount: float):
	trauma = min(trauma + amount, 1.0)
