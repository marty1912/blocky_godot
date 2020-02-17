extends HBoxContainer

var lifes = 0 setget set_lifes, get_lifes
const heart_scene = preload("res://GUIObjects/Heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func set_lifes(value):
    if value < 0:
        print("invalid value!")
        return
    lifes = get_lifes()
        
    while lifes < value:
        var heart = heart_scene.instance()
        add_child(heart)
        lifes+=1
        
    while lifes > value:
        get_children()[0].queue_free()
        lifes-=1

func get_lifes():
    return get_child_count()  