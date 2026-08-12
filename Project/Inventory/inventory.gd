extends Resource

class_name inventory

@export var items: Array[enemy]

func inventory_full() -> bool:
	var available_slots = items.filter(func(slot): return slot == null)
	return available_slots.is_empty()

func pickup_item(item):
	var index = items.find(null)
	if index != -1:
		items[index] = item
	SignalManager.update_inventory_ui.emit()
