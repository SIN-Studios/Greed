extends Control

var active_tween: Tween
@onready var lava = $Lava
@onready var plains = $Plains
@onready var forest = $Forest

func _ready() -> void:
	print("Script running on node: ", get_path())
	SignalManager.lava.connect(lava_area_entered)
	SignalManager.plains.connect(plains_entered)
	SignalManager.forest.connect(forest_entered)
	lava.hide()
	plains.hide()
	forest.hide()

func show_area_text(target_node: Control) -> void:
	if active_tween and active_tween.is_running():
		active_tween.kill()
	lava.hide()
	plains.hide()
	forest.hide()
	target_node.show()
	modulate.a = 0.0
	active_tween = create_tween()
	active_tween.tween_property(self, "modulate:a", 1.0, 1.0)
	active_tween.tween_interval(3.6)
	active_tween.tween_property(self, "modulate:a", 0.0, 1.0)
	active_tween.tween_callback(target_node.hide)

func lava_area_entered() -> void:
	print('lava')
	show_area_text(lava)

func forest_entered() -> void:
	print('forest')
	show_area_text(forest)

func plains_entered() -> void:
	print('plains')
	show_area_text(plains)
