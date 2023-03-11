extends KinematicBody2D


signal health_changed(from,to)

const MAX_SPEED = 450
const ACCELERATION = 600
const FRICTION = 2000
const JUMP_SPEED = 555

var velocity = Vector2()

var HP = 150

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func dep_health(amt):
	HP = HP - amt
	$HPLabel.text = str(HP)


func _ready():
	$HPLabel.text = str(HP)
	pass

func _physics_process(delta):
	var move = ACCELERATION * (Input.get_axis("move_left", "move_right"))
	if velocity.y > 0 and !is_on_floor():
		$AnimatedSprite.animation = "falling"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "jump"
	else:
		$AnimatedSprite.animation = "walk"
	if velocity.length() > 0:
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.set_frame(0) 
		$AnimatedSprite.stop()
	if abs(move) < ACCELERATION * 0.1:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	else:
		$AnimatedSprite.animation = "walk"
	if abs(move) < ACCELERATION * 0.1:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		$AnimatedSprite.set_frame(0) 
		$AnimatedSprite.stop()
	else:
		$AnimatedSprite.flip_h = velocity.x < 0
		var acceleration = move * delta
		if velocity.x * move < 0:
			acceleration *= 5
		acceleration = clamp(acceleration, -MAX_SPEED - velocity.x, MAX_SPEED - velocity.x)        
		velocity.x += acceleration
		$AnimatedSprite.play()
	velocity.y += gravity * delta
	
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
