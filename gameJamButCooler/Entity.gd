extends KinematicBody2D




var HP = 150

func _ready():
    pass


func dep_health(amt):
    HP = HP - amt
    $HPLabel.text = str(HP)
    
    
