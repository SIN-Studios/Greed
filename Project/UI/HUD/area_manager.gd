extends Control
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


func lava_area_entered():
	print('lava')
	lava.show()
	
func forest_entered():
	print('forest')
	forest.show()
	
func plains_entered():
	print('plains')
	plains.show()
	
