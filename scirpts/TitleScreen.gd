extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    print("loading Titlescreen")
    for button in $Menu/CenterRow/Buttons.get_children():
        print("adding button callback")
        button.connect("pressed",self, "_on_Button_pressed",[button.scene_to_load])
    print("loading Titlescreen finished")
        

func _on_Button_pressed(scene_to_load):
    print("on button pressed in Titlescreen : scene to load: " + scene_to_load)
    if scene_to_load == "quit":
        get_tree().quit()
    Global.goto_scene(scene_to_load)
        

