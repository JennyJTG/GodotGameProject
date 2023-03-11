extends KinematicBody2D

const MAX_SPEED = 450
const ACCELERATION = 600
const FRICTION = 2000
const JUMP_SPEED = 555

var velocity = Vector2()
onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
    pass

func _physics_process(delta):
    var move = ACCELERATION * (Input.get_axis("move_left", "move_right"))
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
