# SimpleInventory.gd (Autoload - configure EM 1 MINUTO)
extends Node

var items = []

func _ready():
	items.resize(3)
	print("🎒 Inventário simples iniciado")

func add_item(item_id: String):
	for i in range(3):
		if items[i] == null:
			items[i] = item_id
			print("➕ Item adicionado: ", item_id)
			return i
	print("❌ Inventário cheio!")
	return -1

func remove_item(slot: int):
	if slot >= 0 and slot < 3:
		var item = items[slot]
		items[slot] = null
		print("➖ Item removido: ", item)
		return item
	return null
