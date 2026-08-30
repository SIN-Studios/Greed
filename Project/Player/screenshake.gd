extends Camera2D


@export var random_strength: float = 5.0
@export var max_shake: float = 15.0
@export var shake_decay_rate: float = 5.0

var shake_strength: float = 0.0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	SignalManager.shake_requested.connect(apply_shake)
	if SignalManager.has_signal("shake_stop_requested"):
		SignalManager.shake_stop_requested.connect(_on_shake_stop_requested)

func apply_shake(intensity: float) -> void:
	var added_shake = intensity * random_strength
	shake_strength = min(shake_strength + added_shake, max_shake)

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = move_toward(shake_strength, 0.0, shake_decay_rate * delta)
		offset = get_random_offset()
	else:
		offset = Vector2.ZERO

func get_random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_strength, shake_strength),
		rng.randf_range(-shake_strength, shake_strength)
	)
	
func _on_shake_stop_requested() -> void:
	shake_strength = 0.0
	offset = Vector2.ZERO
