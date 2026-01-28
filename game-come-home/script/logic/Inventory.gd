extends Node

var allow_interaction := false

var items := {}  
# id -> posição no mundo

func add_item(id: String, world_pos: Vector2):
	items[id] = world_pos
	save()

func remove_item(id: String) -> Vector2:
	if not items.has(id):
		push_warning("Tentou remover item inexistente: " + id)
		return Vector2.ZERO

	var pos: Vector2 = items[id]
	items.erase(id)
	save()
	return pos


func save():
	var f = FileAccess.open("user://inventory.save", FileAccess.WRITE)
	f.store_var(items)

func load():
	if FileAccess.file_exists("user://inventory.save"):
		var f = FileAccess.open("user://inventory.save", FileAccess.READ)
		items = f.get_var()
