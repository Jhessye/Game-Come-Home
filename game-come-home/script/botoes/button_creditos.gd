extends Button

@export var next_scene: String = "res://cenas/tela inicial/title_screem.tscn"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.stop()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	get_tree().change_scene_to_file(next_scene)


func _on_mouse_entered() -> void:
	audio_stream_player.stop()
	audio_stream_player.play()
