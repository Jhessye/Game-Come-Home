extends Area2D

@export var target_scene := "res://cenas/jogaveis/cena_3.tscn"
@export var spawn_id := "voltar_caverna"

func _on_body_entered(body):
	if body is CharacterBody2D:
		GameState.spawn_point = spawn_id
		get_tree().change_scene_to_file(target_scene)
