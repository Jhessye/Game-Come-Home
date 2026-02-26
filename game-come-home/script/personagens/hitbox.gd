extends Area2D

@export var damage := 1

func _ready():
	monitoring = false

func enable():
	monitoring = true

func disable():
	monitoring = false

func _on_body_entered(body):

	if body.has_method("take_damage"):
		body.take_damage(damage)
	get_parent().queue_free()
