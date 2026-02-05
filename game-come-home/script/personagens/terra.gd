extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_hitbox: Area2D = $hitbox

@export var player: Node2D          # arraste o player no Inspector
@export var left_limit: Marker2D    # limite esquerdo
@export var right_limit: Marker2D   # limite direito

enum TerraState {
	WALK,
	ATTACK,
	HURT,
	DYING
}

const SPEED := 120.0
const GRAVITY := 900.0
const ATTACK_DISTANCE := 40.0

const MAX_HP := 3
var hp := MAX_HP

var status: TerraState = TerraState.WALK
var direction := 1   # 1 = direita | -1 = esquerda

# =========================
func _ready() -> void:
	attack_hitbox.monitoring = false
	go_to_walk_state()

# =========================
func _physics_process(delta: float) -> void:
	if status == TerraState.DYING:
		return

	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	match status:
		TerraState.WALK:
			walk_state()
		TerraState.ATTACK:
			attack_state()
		TerraState.HURT:
			hurt_state()
		TerraState.DYING:
			dying_state()

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
	velocity = Vector2.ZERO
	attack_hitbox.monitoring = false

# =========================
# STATES
# =========================
func walk_state():
	velocity.x = direction * SPEED

	# Flip visual
	anim.flip_h = direction < 0

	# 🧱 Limites de patrulha
	if left_limit and global_position.x <= left_limit.global_position.x:
		direction = 1
	elif right_limit and global_position.x >= right_limit.global_position.x:
		direction = -1

	# 🧠 Detecta player
	if player:
		var dist := global_position.distance_to(player.global_position)
		if dist <= ATTACK_DISTANCE:
			go_to_attack_state()

func attack_state():
	velocity.x = 0

	if not anim.is_playing():
		attack_hitbox.monitoring = false
		go_to_walk_state()

func hurt_state():
	velocity.x = 0

	if not anim.is_playing():
		go_to_walk_state()

func dying_state():
	velocity = Vector2.ZERO

# =========================
# HITBOX / DANO
# =========================
func take_damage(amount := 1):
	if status == TerraState.DYING:
		return

	hp -= amount
	print("Inimigo HP:", hp)

	if hp <= 0:
		go_to_dying_state()
	else:
		go_to_hurt_state()

# =========================
# HITBOX DE ATAQUE
# =========================
func enable_attack_hitbox():
	attack_hitbox.monitoring = true

func disable_attack_hitbox():
	attack_hitbox.monitoring = false
