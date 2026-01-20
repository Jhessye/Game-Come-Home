extends Button

@onready var hover_sound: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	# garante que não esteja tocando
	hover_sound.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/jogaveis/quarto.tscn")

func _on_bnt_sair_pressed() -> void:
	get_tree().quit()

func _on_bnt_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/tela inicial/creditos.tscn")

func _on_bnt_sair_mouse_entered() -> void:
	hover_sound.stop()
	hover_sound.play()

func _on_mouse_entered() -> void:
	hover_sound.stop()
	hover_sound.play()


func _on_bnt_creditos_mouse_entered() -> void:
	hover_sound.stop()
	hover_sound.play()
