extends Area2D

@export var damage := 1

func _ready():
	monitoring = false

func enable():
	monitoring = true

func disable():
	monitoring = false

func _on_body_entered(area):
	var enemy = area.get_parent()
	if enemy.has_method("take_damage"):
		enemy.take_damage(1)
