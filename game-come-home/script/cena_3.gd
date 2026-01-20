extends Node2D
@onready var level_end: Area2D = $level_end

@onready var anim: AnimatedSprite2D = $player/anim
@onready var player2: Sprite2D = $player/player

@onready var player: CharacterBody2D = $player
@onready var spawns = $SpawnPoints

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudioStreamPlayer.stop()
	SongBg.play_music_level()
	
	if spawns.has_node(GameState.spawn_point):
		player2.flip_h = false
		anim.flip_h = true
		player.global_position = spawns.get_node(GameState.spawn_point).global_position

	
	
