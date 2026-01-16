extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
@onready var grid = $GridContainer

func has_item(id):
	for slot in grid.get_children():
		if slot.item_data != null and slot.item_data.id == id:
			return true
	return false

func _can_drop_data(position, data):
	return data.has("texture")

func _drop_data(position, data):
	for slot in grid.get_children():
		if slot.is_empty():
			slot.set_item({ "texture": data.texture })

			# REMOVE DO MUNDO
			if data.has("world_node"):
				data.world_node.queue_free()

			return
			
func _unhandled_drop_data(position, data):
	if not data.has("item_data"):
		return

	var item_data = data.item_data

	# recria o item no mundo
	var item = item_data.scene.instantiate()
	item.texture = item_data.texture
	item.global_position = item_data.world_position

	get_tree().current_scene.add_child(item)

	# limpa slot de origem
	if data.has("from_slot"):
		data.from_slot.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
