extends Control

var slots: Array[TextureButton] = []
var selected_index := -1


func _ready():
	slots.clear()
	find_slots(self)
	# 🔥 NÃO seleciona nada de início
	# select_slot(0)  # <-- REMOVA ISSO
	selected_index = -1
	refresh()

# 🔥 NOVO: método para resetar ao fechar inventário
func close_inventory():
	if selected_index != -1:
		slots[selected_index].set_selected(false)
		selected_index = -1
	
func get_selected_item_id() -> String:
	if selected_index == -1:
		return ""
	return slots[selected_index].item_id


func _unhandled_input(event):
	if event.is_action_pressed("slot_1"):
		select_slot(0)
	elif event.is_action_pressed("slot_2"):
		select_slot(1)
	elif event.is_action_pressed("slot_3"):
		select_slot(2)

func select_slot(index: int):
	# se clicar no mesmo slot → deseleciona
	if selected_index == index:
		slots[selected_index].set_selected(false)
		selected_index = -1
		return

	# desmarca anterior
	if selected_index != -1:
		slots[selected_index].set_selected(false)

	# seleciona novo
	if index >= 0 and index < slots.size():
		selected_index = index
		slots[selected_index].set_selected(true)


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
