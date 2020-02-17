extends Node

var current_scene = null
var score = 0 setget set_score
var lifes = 3 

func _ready():
    print("loading global")
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)

func set_score(value):
    score = value
    print("(set_score) global")
    
func goto_scene(path):
    print("change scene to:"+ path +"current_scene:" +str(current_scene.name) )
    # This function will usually be called from a signal callback,
    # or some other function in the current scene.
    # Deleting the current scene at this point is
    # a bad idea, because it may still be executing code.
    # This will result in a crash or unexpected behavior.

    # The solution is to defer the load to a later time, when
    # we can be sure that no code from the current scene is running:

    call_deferred("_deferred_goto_scene", path)

func reset():
    score = 0
    lifes = 3
    return 
    
func _deferred_goto_scene(path):
    if path == "quit":
        get_tree().quit()
        return
    else:
        print("in defered func. scene to load:" + path)
        # It is now safe to remove the current scene
        current_scene.free()
    
        # Load the new scene.
        var s = ResourceLoader.load(path)
    
        # Instance the new scene.
        current_scene = s.instance()
    
        # Add it to the active scene, as child of root.
        get_tree().get_root().add_child(current_scene)
        # Optionally, to make it compatible with the SceneTree.change_scene() API.
        get_tree().set_current_scene(current_scene)
        