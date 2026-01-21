extends TextureRect
@export var item_id: String

func _get_drag_data(_position):
	print("DRAG COMEÇOU:", item_id)

	var preview_container := Control.new()
	preview_container.custom_minimum_size = Vector2(32, 32)

	var icon := TextureRect.new()
	icon.texture = texture
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	# 🔥 ISSO É O QUE REALMENTE FUNCIONA
	icon.scale = Vector2(
		32.0 / texture.get_width(),
		32.0 / texture.get_height()
	)

	preview_container.add_child(icon)
	set_drag_preview(preview_container)

	return {
		"item_data": {
			"id": item_id,
			"texture": texture,
			"world_node": self
		}
	}
