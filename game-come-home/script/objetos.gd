extends TextureRect
@export var item_id: String

var original_parent
var original_position

func _ready():
	original_parent = get_parent()
	original_position = global_position

func _get_drag_data(position):
	var preview_container = Control.new()
	preview_container.custom_minimum_size = Vector2(32, 32)

	var icon = TextureRect.new()
	icon.texture = texture
	icon.custom_minimum_size = Vector2(32, 32)
	icon.size = Vector2(32, 32)
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
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
			"world_node": self,
			"original_parent": original_parent,
			"original_position": original_position
		}
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
