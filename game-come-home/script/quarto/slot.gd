extends TextureRect

var item_data = null


func _can_drop_data(position, data):
	if not data.has("item_data"):
		return false

	var id = data.item_data.id
	var inventory = get_parent().get_parent() # inventário

	if inventory.has_item(id):
		return false

	return item_data == null


func _drop_data(position, data):
	if item_data != null:
		return

	item_data = data.item_data
	texture = item_data.texture

	# ESCONDE objeto do mundo (NÃO DESTRÓI)
	if item_data.has("world_node"):
		item_data.world_node.visible = false


func _get_drag_data(position):
	if item_data == null:
		return null

	var preview_container = Control.new()
	preview_container.custom_minimum_size = Vector2(32, 32)

	var icon = TextureRect.new()
	icon.texture = texture
	icon.custom_minimum_size = Vector2(32, 32)
	icon.size = Vector2(32, 32)
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	# 🔥 CORREÇÃO DO TAMANHO (IGUAL AO OBJETO)
	icon.scale = Vector2(
		32.0 / texture.get_width(),
		32.0 / texture.get_height()
	)

	preview_container.add_child(icon)
	set_drag_preview(preview_container)

	return {
		"item_data": item_data,
		"from_slot": self
	}

func clear():
	item_data = null
	texture = null
