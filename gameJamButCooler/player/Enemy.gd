extends "res://Entity.gd"



var velocity = Vector2()
var pastPosition = position
var faceRight = -1
onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _ready():
    HP = 25
    velocity.x = 100
    $HPLabel.text = str(HP)
    pass



func _physics_process(delta):
    velocity.y += gravity * delta
    velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
    $AnimatedSprite.animation = "walk"
    if velocity.length() > 0:
        $AnimatedSprite.flip_h = velocity.x < 0
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.set_frame(0) 
        $AnimatedSprite.stop()
    if position == pastPosition:
        velocity.x = 100*faceRight
        faceRight *= -1
    pastPosition = position
    
func _on_Area2D_body_entered(body):
    var hit = body
    if hit.get_name() == "Player":
        if hit.HP > 0:
            hit.dep_health(HP)
            dep_health(HP)
    pass

