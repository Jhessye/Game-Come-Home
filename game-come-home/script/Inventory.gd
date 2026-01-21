extends Node

const SLOT_COUNT := 3

var slots := []

func _ready():
	slots.resize(SLOT_COUNT)
	slots.fill(null)

func set_item(slot: int, item_id: String):
	slots[slot] = item_id

func get_item(slot: int):
	return slots[slot]

func clear_slot(slot: int):
	slots[slot] = null
