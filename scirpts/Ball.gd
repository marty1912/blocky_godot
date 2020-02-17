extends RigidBody2D

const splash_scene = preload("res://gameObjects/Splash.tscn")
export var SPEEDUP = 50
const MAXSPEED = 500
var launch_mode = false setget set_launch_mode

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("/root/World").ball_add()
    pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if !launch_mode:
        var bodies = get_colliding_bodies()
        for body in bodies:
            if body.is_in_group("bricks"):
                get_node("/root/World").score += 5
                body.is_dead = true


            if body.get_name() == "Bar":
                var speed = get_linear_velocity().length()
                var direction = get_node("Anchor").get_global_position() - body.get_node("Anchor").get_global_position()
                var vel = direction.normalized() * min(speed+SPEEDUP,MAXSPEED)
                set_linear_velocity(vel)

            var splash = splash_scene.instance()
            var splash_pos = get_node("Anchor").get_global_position()
            splash.position.x = splash_pos.x
            splash.position.y = splash_pos.y
            get_tree().get_root().add_child(splash)



    if get_node("Anchor").get_global_position().y > get_viewport_rect().end.y:
        print("(ball) leaving")
        get_node("/root/World").ball_leave()
        queue_free()


func set_launch_mode(value):
    print("launch mode)")
    launch_mode = value
    if value:
        self.bounce = 0.0
        self.friction = 1.0
    else:
        self.bounce = 1.0
        self.friction = 0.0


