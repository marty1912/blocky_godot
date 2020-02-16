extends KinematicBody2D

var motion = Vector2()
var last_collision = Vector2()

const MAXSPEED = 500
const speed = 30
const cutoff = 5
const ball_scene = preload("res://gameObjects/Ball.tscn")
const splash_scene = preload("res://gameObjects/Splash.tscn")

var can_launch_ball = true
var launch_mode = false
var ball;

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("LaunchCollision").disabled = true

    pass # Replace with function body.

func _physics_process(delta):

    motion = normal_movement()

    handle_collision(move_and_collide(motion*delta))






func normal_movement():
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
    return motion


func handle_collision(colission):
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
            if launch_mode:
                get_node("LaunchCollision").disabled = true
                ball.launch_mode = false
                ball.set_linear_velocity(Vector2(0,300))
                can_launch_ball = false
                launch_mode = false
            else:
                ball = ball_scene.instance()
                launch_mode = true
                var ball_position = get_node("Anchor").get_global_position() - Vector2(0,32)
                ball.position.x = ball_position.x
                ball.position.y = ball_position.y - 0.1
                ball.linear_velocity = Vector2(0,0)
                ball.launch_mode = true
                get_tree().get_root().add_child(ball)
                motion.x = 0
                motion.y = 0
                get_node("LaunchCollision").disabled = false

