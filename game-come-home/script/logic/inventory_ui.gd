extends Control

var slots: Array[TextureButton] = []

func _ready():
	slots.clear()
	find_slots(self)
	refresh()

func refresh():
	print("REFRESH INVENTORY UI")

	for slot in slots:
		slot.clear()

	var item_ids := Inventory.items.keys()  # <<< AQUI ESTÁ O FIX

	for i in range(min(slots.size(), item_ids.size())):
		var item_id = item_ids[i]
		slots[i].set_item(item_id)

			
func find_slots(node: Node):
	for child in node.get_children():
		if child is TextureButton and child.has_method("set_item"):
			slots.append(child)
		find_slots(child)
