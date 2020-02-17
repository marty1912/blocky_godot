extends Button

export (String) var scene_to_load

func _ready():
    print("button loading. scene to load: " + scene_to_load) 
    