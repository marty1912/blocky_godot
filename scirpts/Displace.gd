extends ColorRect

var elapsed_time = 0.0
export var threshhold = 1.0
var disp_amt = 0
var disp_size = 0
export var time_factor = 0.999

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_viewport().size
	self.set_size(size)
	

func _process(delta):
	elapsed_time+=delta
	if elapsed_time > threshhold:
		elapsed_time = 0
		threshhold = rand_range(0.0,0.1)
		disp_amt = rand_range(0,0.001)
		disp_size = rand_range(1,1.1)
		var abberation_x = rand_range(0,0.0025)
		var abberation_y = rand_range(0,0.0025)
		
		get_material().set_shader_param("displace_amt", disp_amt)
		get_material().set_shader_param("displace_size", disp_size)
		get_material().set_shader_param("abberation_amt_x", abberation_x)
		get_material().set_shader_param("abberation_amt_y", abberation_y)
		
	#else:
	#	disp_amt = disp_amt * time_factor
	#	disp_size = disp_size * time_factor
	#	get_material().set_shader_param("displace_amt", disp_amt)
	#	get_material().set_shader_param("displace_size", disp_size)