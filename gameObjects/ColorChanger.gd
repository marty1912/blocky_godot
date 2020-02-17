extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
    add_to_group("color_change")
    $AnimationPlayer.play("change_colors")
    pass # Replace with function body.
