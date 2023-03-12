extends "res://Entity.gd"



##Among us
##Haha whoever wrote play I stole all yer scripts
var velocity = Vector2()
onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _ready():
    HP = 25
    $HPLabel.text = str(HP)
    pass



func _physics_process(delta):
    velocity.y += gravity * delta
    velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)



func _on_Area2D_body_entered(body):
    var hit = body
    if hit.get_name() == "Player":
        if hit.HP > 0:
            hit.dep_health(HP)
            dep_health(HP)
    pass
