extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudioStreamPlayer.stop()
	SongBg.stop()
	SongBueiro.play_music_level()
	Inventory.allow_interaction = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
