extends Area2D

signal hit

export var speed = 400
var screen_size

func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false

func _ready():
    hide()
    screen_size = get_viewport_rect().size

func _process(delta):
    var velocity = Vector2.ZERO
    if Input.is_action_pressed("move_right"):
        velocity.x += 1
    if Input.is_action_pressed("move_left"):
        velocity.x -= 1
    if Input.is_action_pressed("move_down"):
        velocity.y += 1
    if Input.is_action_pressed("move_up"):
        velocity.y -= 1
        
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
        
    if velocity.x != 0:
        $AnimatedSprite.animation = "walk"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 0
    elif velocity.y != 0:
        $AnimatedSprite.animation = "up"
        $AnimatedSprite.flip_v = velocity.y > 0
        
    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
    hide()
    emit_signal("hit")
    $CollisionShape2D.set_deferred("disabled", true)
