extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var motion = Vector2()
const MAXSPEED = 500
const speed = 30
const cutoff = 5
const ball_scene = preload("res://gameObjects/Ball.tscn")

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_accept"):
		var ball = ball_scene.instance()
		var ball_position = get_node("Anchor").get_global_position() - Vector2(0,32)
		ball.position.x = ball_position.x
		ball.position.y = ball_position.y
		get_tree().get_root().add_child(ball)
		
