extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.allow_interaction = true

	GlobalAudioStreamPlayer.stop()
	SongBg.play_music_level()
	# 1. Carrega inventário
	Inventory.load()
	
	# 2. Atualiza slots (se houver slots na cena)
	update_slots_in_scene()
	
	# 3. Esconde objetos coletados
	hide_collected_objects()
	
func update_slots_in_scene():
	# Encontra slots na cena e atualiza
	for node in get_tree().get_nodes_in_group("slot"):
		if node.has_method("load_saved_item"):
			node.load_saved_item()

func hide_collected_objects():
	# Esconde objetos que já estão no inventário
	for node in get_tree().get_nodes_in_group("collectible"):
		if node.has_method("check_if_in_inventory"):
			node.check_if_in_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
