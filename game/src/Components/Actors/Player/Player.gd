extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.30
const AIR_RESISTANCE = 0.02
const GRAVITY = 400
const JUMP_FORCE = 164

var ON_FLOOR
var JUMPING = false
var FACING = 1
var DASHING = false

onready var animationPlayer = $AnimationPlayer
var BULLET_PATH = preload("res://src/Components/Weapons/Bullet/Bullet.tscn")

signal absorbing_blood
signal stop_absorbing_blood

func _ready():
	Autoload.Player = self

func _physics_process(delta):
	if is_on_floor():
		ON_FLOOR = true
	else:
		ON_FLOOR = false
	
	if direction.x != 0 and DASHING == false:
		animationPlayer.play('run')
		velocity.x = direction.x * ACCELERATION
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	else:
		animationPlayer.play('idle')
	
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if ON_FLOOR:
		if direction.x == 0:
			velocity.x = lerp(velocity.x, 0, FRICTION)
	else:
		animationPlayer.play('jump')
		if direction.x == 0:
			velocity.x = lerp(velocity.x, 0, AIR_RESISTANCE)

func _unhandled_input(_event):
	get_direction()
	jump()
	jump_cancel()
	shoot()
	absorb()
#	dash()
	
	
func get_direction():
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if direction.x == 1:
		FACING = direction.x
		$Sprite.flip_h = false
	elif direction.x == -1:
		FACING = direction.x
		$Sprite.flip_h = true
	
func jump():
	if Input.is_action_just_pressed("jump") and ON_FLOOR == true:
		velocity.y = -JUMP_FORCE
		JUMPING = true

func jump_cancel():
	if Input.is_action_just_released("jump"):
		if velocity.y < 100:
			velocity.y *= 0.2

func shoot():
	if Input.is_action_just_pressed('shoot'):
		if ON_FLOOR == false:
			velocity.y -= 50
		var bullet = BULLET_PATH.instance()
		bullet.global_position = global_position
		bullet.direction.x = FACING
		owner.add_child(bullet)

func absorb():
	if Input.is_action_pressed("absorb"):
		$CanvasLayer/HUD/Label2.text = "X"
		emit_signal("absorbing_blood")
	elif Input.is_action_just_released("absorb"):
		$CanvasLayer/HUD/Label2.text = ""
		emit_signal("stop_absorbing_blood")

func dash():
	if Input.is_action_just_pressed("dash") and DASHING == false:
		print("DASHING")
		DASHING = true
		velocity.x = 200 * FACING
		yield(get_tree().create_timer(1), "timeout")
		DASHING = false
