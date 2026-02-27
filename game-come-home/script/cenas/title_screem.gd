extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudioStreamPlayer.play_music_level()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	GlobalAudioStreamPlayer.play_music_level()
	
