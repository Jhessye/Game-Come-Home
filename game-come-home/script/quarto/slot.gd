extends TextureRect

var item_data = null

func _can_drop_data(_position, data):
	return item_data == null and data.has("item_data")

func _drop_data(_position, data):
	item_data = data.item_data
	texture = item_data.texture

	# esconde do mundo
	item_data.world_node.visible = false
