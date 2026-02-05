extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var player: Node2D   # arrasta o player no Inspector

enum TerraState {
	WALK,
	ATTACK,
	HURT,
	DYING
}

const SPEED = 120.0
const GRAVITY = 900.0
const ATTACK_DISTANCE = 40.0

var status: TerraState = TerraState.WALK
var direction := 1   # 1 = direita | -1 = esquerda

func _ready() -> void:
	go_to_walk_state()

func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	match status:
		TerraState.WALK:
			walk_state(delta)
		TerraState.ATTACK:
			attack_state(delta)
		TerraState.HURT:
			hurt_state(delta)
		TerraState.DYING:
			dying_state(delta)

	move_and_slide()

# =========================
# TRANSIÇÕES
# =========================
func go_to_walk_state():
	status = TerraState.WALK
	anim.play("walk")

func go_to_attack_state():
	status = TerraState.ATTACK
	anim.play("attack")

func go_to_hurt_state():
	status = TerraState.HURT
	anim.play("hurt")

func go_to_dying_state():
	status = TerraState.DYING
	anim.play("dying")

# =========================
# STATES
# =========================
func walk_state(_delta):
	velocity.x = direction * SPEED

	# Flip visual
	anim.flip_h = direction < 0

	# 🧠 Checa distância do player
	if player:
		var dist = global_position.distance_to(player.global_position)
		if dist <= ATTACK_DISTANCE:
			go_to_attack_state()

	# 🧱 Exemplo simples de virar (borda / parede)
	if is_on_wall():
		direction *= -1

func attack_state(_delta):
	velocity.x = 0

	# Espera animação acabar para voltar a andar
	if not anim.is_playing():
		go_to_walk_state()

func hurt_state(_delta):
	velocity.x = 0

	if not anim.is_playing():
		go_to_walk_state()

func dying_state(_delta):
	velocity = Vector2.ZERO
