extends Node

export(PackedScene) var mob_scene
var score
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func game_over():
    $ScoreTimer.stop()
    $MobTimer.stop()
    $HUD.show_game_over()

func new_game():
    score = 0
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")
    get_tree().call_group("mobs", "queue_free")
    
func _on_ScoreTimer_timeout():
    score += 1
    $HUD.update_score(score)

func _on_StartTimer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()
    
func _on_MobTimer_timeout():
    # Create a new instance of the Mob scene.
    var mob = mob_scene.instance()

    # Choose a random location on Path2D.
    var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
    mob_spawn_location.offset = randi()

    # Set the mob's direction perpendicular to the path direction.
    var direction = mob_spawn_location.rotation + PI / 2

    # Set the mob's position to a random location.
    mob.position = mob_spawn_location.position

    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4)
    mob.rotation = direction

    # Choose the velocity for the mob.
    var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
    mob.linear_velocity = velocity.rotated(direction)

    # Spawn the mob by adding it to the Main scene.
    add_child(mob)
    
# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
