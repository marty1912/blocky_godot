extends Node2D

export var life_time = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("ParticleRender/Brick").is_dead = true
    yield(get_tree().create_timer(life_time), "timeout")
    queue_free()


