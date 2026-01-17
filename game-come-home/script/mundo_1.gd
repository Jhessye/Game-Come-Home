extends Control
@onready var hover_sound: AudioStreamPlayer = $CheckButton/AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _can_drop_data(position, data):
	return data.has("item_data")


func _drop_data(position, data):
	var item = data.item_data
	var slot = data.get("from_slot")

	if slot:
		slot.item_data = null
		slot.texture = null

	var obj = item.world_node
	obj.visible = true
	obj.get_parent().remove_child(obj)
	add_child(obj)

	obj.global_position = item.original_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_check_button_mouse_entered() -> void:
	hover_sound.stop()
	hover_sound.play()
