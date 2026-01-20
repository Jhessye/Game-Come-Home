extends Area2D

@export var next_scene: String = "res://cenas/jogaveis/bueiro_1.tscn"

@onready var label: Label = $Label

var player_inside := false


func _ready():
	label.visible = false


func _on_body_entered(body):
	if body is CharacterBody2D:
		player_inside = true
		label.visible = true
		label.text = "Pressione E"

func _on_body_exited(body):
	if body is CharacterBody2D:
		player_inside = false
		label.visible = false

func _process(_delta):
	if player_inside and Input.is_action_just_pressed("entrarbueiro"):
		get_tree().change_scene_to_file(next_scene)
