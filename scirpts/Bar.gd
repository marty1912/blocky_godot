extends KinematicBody2D

var motion = Vector2()
var last_collision = Vector2()

const MAXSPEED = 500
const speed = 30
const cutoff = 5
const ball_scene = preload("res://gameObjects/Ball.tscn")
const splash_scene = preload("res://gameObjects/Splash.tscn")

var can_launch_ball = true

# Called when the node enters the scene tree for the first time.
func _ready():

    pass # Replace with function body.

func _physics_process(delta):
    # motion
    if Input.is_action_pressed("ui_right"):
        motion.x += speed
    elif Input.is_action_pressed("ui_left"):
        motion.x -= speed
    else:
        # smooth stop
        motion.x = motion.x * 0.9

    if abs(motion.x) < cutoff:
        motion.x = 0
    elif abs(motion.x) > MAXSPEED:
        if motion.x < 0:
            motion.x = -MAXSPEED
        else:
            motion.x = MAXSPEED

    var colission = move_and_collide(motion*delta)


    if colission != null :
        if colission.position != last_collision:
            var splash = splash_scene.instance()
            var splash_pos = colission.position
            splash.position.x = splash_pos.x
            splash.position.y = splash_pos.y
            get_tree().get_root().add_child(splash)
            last_collision = splash_pos

func _input(event):
    if can_launch_ball:
        if event.is_action_pressed("ui_accept"):
            var ball = ball_scene.instance()
            var ball_position = get_node("Anchor").get_global_position() - Vector2(0,32)
            ball.position.x = ball_position.x
            ball.position.y = ball_position.y
            get_tree().get_root().add_child(ball)
            can_launch_ball = false

