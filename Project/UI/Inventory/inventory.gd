extends Resource

class_name inventory

@export var items: Array[enemy]

func pickup_item(picked_up_item):
	var available_slots = items.filter(func(slot): return slot == null)
	if not available_slots.is_empty():
		var index = items.find(null)
		if index != -1:
			items[index] = picked_up_item
	SignalManager.update_inventory_ui.emit()
