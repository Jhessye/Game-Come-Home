extends Node

var ITEMS = {
	"mapa": {
		"texture": preload("res://home_1/mapa.png")
	},
	"espada": {
		"texture": preload("res://home_1/espada.png")
	},
	"escudo": {
		"texture": preload("res://home_1/escudo.png")
	}
}

func get_item(id):
	return ITEMS.get(id)
