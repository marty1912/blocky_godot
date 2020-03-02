extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _on_AmbientSound_finished():
    play()
