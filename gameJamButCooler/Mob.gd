extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite2D.play()
    var mob_types = $AnimatedSprite2D.get_sprite_frames().get_animation_names()
    $AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
    pass
    
func _on_visible_on_screen_notifier_2d_screen_exited():
    queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
