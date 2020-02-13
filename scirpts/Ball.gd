extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var SPEEDUP = 50
const MAXSPEED = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("bricks"):
			get_node("/root/World").score += 5
			body.queue_free()
			
			
		if body.get_name() == "Bar":
			var speed = get_linear_velocity().length()
			var direction = get_node("Anchor").get_global_position() - body.get_node("Anchor").get_global_position()
			var vel = direction.normalized() * min(speed+SPEEDUP,MAXSPEED)
			set_linear_velocity(vel)
			print("velocity: " , vel)
			
	if get_node("Anchor").get_global_position().y > get_viewport_rect().end.y:
		print("game over")
		queue_free()
		
	pass

