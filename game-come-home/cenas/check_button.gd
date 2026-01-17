extends CheckButton

@export var next_scene: String = "res://cenas/cena_1.tscn"
@export var delay_seconds: int = 3

@onready var countdown_label: Label = $Label

var _transition_id := 0


func _ready():
	countdown_label.text = ""


func _toggled(button_pressed: bool) -> void:
	if button_pressed:
		start_transition()
	else:
		cancel_transition()


func start_transition():
	_transition_id += 1
	var my_id = _transition_id

	for i in range(delay_seconds, 0, -1):
		# se foi cancelado, para tudo
		if my_id != _transition_id or not button_pressed:
			return

		countdown_label.text = str(i)
		await get_tree().create_timer(1.0).timeout

	# troca de cena se ainda estiver válido
	if my_id == _transition_id and button_pressed:
		get_tree().change_scene_to_file(next_scene)


func cancel_transition():
	_transition_id += 1
	countdown_label.text = ""
