extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed",self, "_on_Button_pressed",[button.scene_to_load])
		

func _on_Button_pressed(scene_to_load):
	if scene_to_load == "unpause":
		self.visible = false
		get_tree().paused = false
	elif scene_to_load == "quit":
		get_tree().quit()
	else:
		get_tree().change_scene(scene_to_load)
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		visible = not visible
		if get_tree().paused:
			$FadeIn.play("fade_in")
