extends RigidBody2D



const material_blue = preload("res://shaders/HOLO_blue.tres")
const material_pink = preload("res://shaders/HOLO.tres")
const splash_scene = preload("res://gameObjects/Splash.tscn")
export var SPEEDUP = 50
const MAXSPEED = 500
var launch_mode = false setget set_launch_mode
var current_color = Global.BALL_COLOR.pink

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("/root/World").ball_add()
    pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if !launch_mode:
        var bodies = get_colliding_bodies()
        for body in bodies:
            if body.is_in_group("color_change"):
                change_color()
                
            if body.is_in_group("bricks"):
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
        self.physics_material_override.bounce = 0.0
        self.physics_material_override.friction = 1.0
        self.set_linear_damp(10.0)
    else:
        self.physics_material_override.bounce = 1.0
        self.physics_material_override.friction = 0.0
        self.set_linear_damp(0.0)

func change_color():
    print("(change color)")
    
    if current_color == Global.BALL_COLOR.pink:
        change_color_to(Global.BALL_COLOR.blue)
        
    elif current_color == Global.BALL_COLOR.blue:
        change_color_to(Global.BALL_COLOR.pink)
        
    get_node("/root/World/Base/Bar").change_color_to(current_color)
       
    
func change_color_to(color):
    if color == Global.BALL_COLOR.pink:
        set_collision_layer(1)
        set_collision_mask(1) 
        $Sprite.material.set_shader_param("color",Global.COLOR_PINK)
        current_color = color
    elif color == Global.BALL_COLOR.blue:
        set_collision_layer(2)
        set_collision_mask(2) 
        $Sprite.material.set_shader_param("color",Global.COLOR_BLUE)
        current_color = color
