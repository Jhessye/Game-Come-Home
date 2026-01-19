extends CharacterBody2D

@onready var player: Sprite2D = $player
@onready var anim: AnimatedSprite2D = $anim
@onready var jump: AudioStreamPlayer = $anim/jump
@onready var walk: AudioStreamPlayer = $anim/walk


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	player.visible = true
	anim.visible = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if not is_on_floor() and walk.playing:
		walk.stop()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		jump.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED

		if is_on_floor() and not walk.playing:
			walk.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		if walk.playing:
			walk.stop()
		
	if is_on_floor():
		if direction > 0:
			player.flip_h = true
			player.visible = false
			
			anim.visible = true
			anim.flip_h = false
			anim.play("walk")
		elif direction < 0:
			player.flip_h = false
			player.visible = false
			
			anim.visible = true
			anim.flip_h = true
			anim.play("walk")
		else:
			player.visible = true
			anim.visible = false
			walk.stop()
			anim.stop()
	else:
		player.visible = false
		anim.visible = true
		
		
		anim.play("jump")

	move_and_slide()
