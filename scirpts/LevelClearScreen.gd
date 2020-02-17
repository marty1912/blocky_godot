extends Control

var next_level = ""
# Called when the node enters the scene tree for the first time.
func _ready():
    #for button in $Menu/CenterRow/Buttons.get_children():
    #    button.connect("pressed",self, "_on_Button_pressed",[button.scene_to_load])
    $"Menu/CenterRow/CenterContainer/NextLevel".text = "NextLevel: " + next_level
    #Global.reset()
    $FadeIn.play("fade_in")
   
        

func _on_Button_pressed(scene_to_load):
    if scene_to_load == "unpause":
        self.visible = false
        get_tree().paused = false
    elif scene_to_load == "quit":
        get_tree().quit()
    else:
        get_tree().paused = false
        Global.goto_scene(scene_to_load)
        
            


func _on_FadeIn_animation_finished(anim_name):
    get_tree().paused = false
    Global.goto_scene(next_level)
