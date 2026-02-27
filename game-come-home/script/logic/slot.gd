extends TextureButton

@export var item_id := ""
@onready var highlight: TextureRect = $Highlight

func _ready():
	ignore_texture_size = true
	stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	custom_minimum_size = Vector2(64, 64)
	clear()

func set_item(new_item_id: String):
	item_id = new_item_id

	var tex: Texture2D = ItemDB.ITEM_ICONS.get(new_item_id)
	texture_normal = tex


func clear():
	item_id = ""
	texture_normal = null
	set_selected(false)
	
func set_selected(selected: bool):
	highlight.visible = selected


func _on_pressed() -> void:
	if not Inventory.allow_interaction:
		return

	if item_id == "":
		return
	
	var world_pos := Inventory.remove_item(item_id)
	spawn_item(world_pos)
	clear()

func spawn_item(world_pos: Vector2):
	var path := "res://items/%s.tscn" % item_id
	var scene_res = load(path)

	if scene_res == null:
		push_error("Item não encontrado: " + path)
		return

	var scene = scene_res.instantiate()
	scene.global_position = world_pos
	get_tree().current_scene.add_child(scene)
