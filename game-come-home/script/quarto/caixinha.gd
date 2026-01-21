extends Control

@onready var grid: GridContainer = $GridContainer

func refresh_all():
	for slot in grid.get_children():
		slot.refresh()
