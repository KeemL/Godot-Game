extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_FALL_SPEED = 1400
const JUMPS = 2

var jump_count = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	if jump_count < JUMPS and not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or jump_count < JUMPS:
			print("Jumping")
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			anim.play("Jump")

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false

	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			jump_count = 0
			anim.play("Idle")

	if velocity.y > 0:
		anim.play("Jump")
	elif velocity.y < 0:
		anim.play("Fall")

	move_and_slide()
