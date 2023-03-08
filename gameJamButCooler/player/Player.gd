extends KinematicBody2D

const MAX_SPEED = 690
const ACCELERATION = 1000
const FRICTION = 2000
const JUMP_SPEED = 555

var velocity = Vector2()
onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
    pass

func _physics_process(delta):
    var move = ACCELERATION * (Input.get_axis("move_left", "move_right"))
    
    if abs(move) < ACCELERATION * 0.1:
        velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
    else:
        var acceleration = move * delta
        if velocity.x * move < 0:
            acceleration *= 5
        acceleration = clamp(acceleration, -MAX_SPEED - velocity.x, MAX_SPEED - velocity.x)        
        velocity.x += acceleration
    
    velocity.y += gravity * delta
    
    velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
    
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        velocity.y = -JUMP_SPEED
