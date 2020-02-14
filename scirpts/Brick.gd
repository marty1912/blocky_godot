extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("bricks")
	randomize()
	$Sprite.get_material().set_shader_param("random_offset", rand_range(0.0,3.0))
	pass # Replace with function body.




