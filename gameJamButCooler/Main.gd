extends Node

func _ready():
    randomize()

func _process(delta):
    if $Player.velocity != null:
        var x = $Player.velocity.x
        var y = $Player.velocity.y
        $HUD.show_message(" Velocity:\n {x}\n {y}".format({"x" : x, "y" : y}))
