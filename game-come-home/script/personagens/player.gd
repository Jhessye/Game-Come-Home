extends CharacterBody2D
@onready var player: Sprite2D = $player
@onready var anim: AnimatedSprite2D = $anim
@onready var jump: AudioStreamPlayer = $anim/jump
@onready var walk: AudioStreamPlayer = $anim/walk
@onready var inventory_ui := get_tree().get_first_node_in_group("inventory_ui")
var inverted_animations = ["idle", "jump_shield", "walk_shield"]


# =========================
# STATES
# =========================
enum PhysicalState {
	IDLE,
	WALK,
	JUMP,
	ATTACK,
	DEFEND
}

enum EquipmentState {
	NONE,
	SWORD,
	SHIELD,
	MAP
}

var physical_state: PhysicalState = PhysicalState.IDLE
var equipment_state: EquipmentState = EquipmentState.NONE
var last_played_animation := ""

# =========================
# CONSTANTS
# =========================
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# =========================
func _ready():
	player.visible = true
	anim.visible = false

# =========================
func _process(_delta):
	# 🔥 Atualiza equipamento baseado no slot selecionado
	if inventory_ui:
		var item_id = inventory_ui.get_selected_item_id()
		set_equipment_from_inventory(item_id)
	
	update_animation()
	
# =========================
# FLIP MANAGEMENT
# =========================
func update_flip_direction(direction: float):
	var current_anim: String
	if anim.is_playing():
		current_anim = anim.animation
	else:
		current_anim = last_played_animation
	
	if current_anim == "":
		return
	
	# Para debug - veja o que está acontecendo
	print("DEBUG - Anim: ", current_anim, " | Dir: ", direction)
	
	# Lógica CORRIGIDA para cada animação
	match current_anim:
		"idle":  # SÓ o idle básico
			# idle já está virado para ESQUERDA
			if direction > 0:  # DIREITA
				anim.flip_h = true   # Inverte
				player.flip_h = true
			elif direction < 0:  # ESQUERDA
				anim.flip_h = false  # Mantém
				player.flip_h = false
		
		"walk_shield":
			# walk_shield já está virado para ESQUERDA (OPOSTO do idle_shield)
			if direction > 0:  # DIREITA
				anim.flip_h = true   # Inverte
				player.flip_h = true
			elif direction < 0:  # ESQUERDA
				anim.flip_h = false  # Mantém
				player.flip_h = false
		
		"jump_shield":
			# jump_shield já está virado para ESQUERDA (igual ao walk_shield)
			if direction > 0:  # DIREITA
				anim.flip_h = true   # Inverte
				player.flip_h = true
			elif direction < 0:  # ESQUERDA
				anim.flip_h = false  # Mantém
				player.flip_h = false
		
		"idle_shield":
			# idle_shield já está virado para DIREITA
			if direction > 0:  # DIREITA
				anim.flip_h = false  # Mantém
				player.flip_h = false
			elif direction < 0:  # ESQUERDA
				anim.flip_h = true   # Inverte
				player.flip_h = true
		
		_:  # Todas outras animações
			# Comportamento padrão (não inverter)
			if direction > 0:  # DIREITA
				anim.flip_h = false
				player.flip_h = false
			elif direction < 0:  # ESQUERDA
				anim.flip_h = true
				player.flip_h = true
	
	# Se direction == 0, não faz nada (mantém estado atual)
# =========================
func update_animation():
	# 🔥 SÓ usa Sprite2D se IDLE + SEM EQUIPAMENTO
	if physical_state == PhysicalState.IDLE and equipment_state == EquipmentState.NONE:
		player.visible = true
		anim.visible = false
		last_played_animation = ""
		return
	
	# 🔥 QUALQUER OUTRA SITUAÇÃO = AnimatedSprite2D
	player.visible = false
	anim.visible = true
	
	var anim_name := ""
	
	# 🔥 Monta o nome base da animação
	match physical_state:
		PhysicalState.IDLE:
			anim_name = "idle"
		PhysicalState.WALK:
			anim_name = "walk"
		PhysicalState.JUMP:
			anim_name = "jump"
		PhysicalState.ATTACK:
			anim_name = "attack"
		PhysicalState.DEFEND:
			anim_name = "defend"
	
	# 🔥 Adiciona o sufixo do equipamento (se tiver)
	match equipment_state:
		EquipmentState.SWORD:
			if physical_state == PhysicalState.ATTACK:
				anim_name = "attack_sword"  # ← Especial: já tem próprio
			elif physical_state == PhysicalState.DEFEND:
				anim_name = "defend"        # ← Não tem defend_sword, usa defend normal
			else:
				anim_name += "_sword"
				
		EquipmentState.SHIELD:
			if physical_state == PhysicalState.ATTACK:
				anim_name = "attack"        # ← Não tem attack_shield, usa attack normal
			elif physical_state == PhysicalState.DEFEND:
				anim_name = "defend_shield" # ← OK
			else:
				anim_name += "_shield"
				
		EquipmentState.MAP:
			# MAP não tem animações específicas
			pass
		EquipmentState.NONE:
			# Se for IDLE sem equipamento, já retornou antes
			pass
	
	# 🔥 VERIFICAÇÃO FINAL: se não existe, tenta versão básica
	if not anim.sprite_frames.has_animation(anim_name):
		print("⚠️ Animação ", anim_name, " não encontrada. Tentando básica...")
		
		# Tenta sem o sufixo
		match physical_state:
			PhysicalState.IDLE:
				anim_name = "idle"  # ← PROBLEMA: não tem idle básico!
			PhysicalState.WALK:
				anim_name = "walk"
			PhysicalState.JUMP:
				anim_name = "jump"
			PhysicalState.ATTACK:
				anim_name = "attack"
			PhysicalState.DEFEND:
				anim_name = "defend"
		
		# Se ainda não existir, mostra erro claro
		if not anim.sprite_frames.has_animation(anim_name):
			push_error(
				"❌ Animação não existe: " + anim_name +
				"\nAnimações disponíveis: " +
				str(anim.sprite_frames.get_animation_names())
			)
			return
	
	# 🔥 Só troca se for diferente
	if last_played_animation != anim_name:
		anim.play(anim_name)
		last_played_animation = anim_name
		print("✓ Tocando: ", anim_name)

# =========================
func _physics_process(delta: float) -> void:
	# 🔥 Se estiver atacando/defendendo, TRAVA até acabar
	if physical_state in [PhysicalState.ATTACK, PhysicalState.DEFEND]:
		move_and_slide()
		return
		
	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# INPUT
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# 🔥 ATAQUE (X)
	if Input.is_action_just_pressed("attack"):
		if equipment_state == EquipmentState.SHIELD:
			physical_state = PhysicalState.DEFEND
		elif equipment_state == EquipmentState.SWORD:
			physical_state = PhysicalState.ATTACK
		else:
			# 🔥 Pode atacar sem equipamento também (se tiver a animação "attack")
			physical_state = PhysicalState.ATTACK
	
	# JUMP
	elif Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump.play()
		velocity.y = JUMP_VELOCITY
		physical_state = PhysicalState.JUMP
	
	# MOVIMENTO
	elif not is_on_floor():
		physical_state = PhysicalState.JUMP
	elif direction != 0:
		physical_state = PhysicalState.WALK
	else:
		physical_state = PhysicalState.IDLE
	
	# VELOCIDADE
	if direction != 0:
		velocity.x = direction * SPEED
		if is_on_floor() and not walk.playing:
			walk.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if walk.playing:
			walk.stop()
	
	# Atualiza flip
	update_flip_direction(direction)
	
	move_and_slide()
# =========================
# INVENTÁRIO → EQUIPAMENTO
# =========================
func set_equipment_from_inventory(item_id: String):
	var old_state = equipment_state
	
	match item_id:
		"espada":
			equipment_state = EquipmentState.SWORD
		"escudo":
			equipment_state = EquipmentState.SHIELD
		"mapa":
			equipment_state = EquipmentState.MAP
		_:
			equipment_state = EquipmentState.NONE
	
	# 🔥 Debug - veja quando muda equipamento
	if old_state != equipment_state:
		print("Equipamento mudou: ", equipment_state)

func _on_anim_animation_finished() -> void:
	if physical_state in [PhysicalState.ATTACK, PhysicalState.DEFEND]:
		physical_state = PhysicalState.IDLE
		print("Animação de ataque/defesa terminou")



func _on_hitbox_area_entered(area: Area2D) -> void:
	if velocity.y > 0:
		area.get_parent().queue_free()
