extends Area2D

@export var item_id: String = "mapa"
@export var icon: Texture2D   # imagem que vai aparecer no inventário

@onready var sprite := $Sprite2D

func _ready():
	sprite.scale = Vector2(0.4, 0.4) # AJUSTE AQUI
	input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:

		# SALVA A POSIÇÃO REAL DO ITEM
		Inventory.add_item(item_id, global_position)

		get_tree().call_group("inventory_ui", "refresh")
		queue_free()
