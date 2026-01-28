extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.allow_interaction = true

	GlobalAudioStreamPlayer.stop()
	pass # Replace with function body.


func _on_pronto_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/jogaveis/cena_.tscn")
