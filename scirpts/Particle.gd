extends StaticBody2D

var _time = 1.0
var _is_dissolving = false
var is_dead = false setget _set_is_dead
var destroy_threshhold = 2


func _ready():
    randomize()
    $Sprite.get_material().set_shader_param("random_offset", rand_range(0.0,3.0))
    
func _process(delta):
    if (_is_dissolving):
        _time += delta;
        $Sprite.material.set_shader_param("dissolve_val", rand_range(0,1/_time))
        $Sprite.material.set_shader_param("displace_amt", rand_range(0,_time))
        $Sprite.material.set_shader_param("brightness", rand_range(0,_time/2))
        $Sprite.material.set_shader_param("alpha", rand_range(0,1/_time))
        $Sprite.material.set_shader_param("abbrevation_x",rand_range(-_time,_time))
        $Sprite.material.set_shader_param("abbrevation_y",rand_range(-_time,_time))
        
        if(_time > destroy_threshhold):
            _is_dissolving = false
            queue_free()

func _set_is_dead(value):
    is_dead = value
    if (value):
        enter_death()

# activates dissolving
func enter_death():
  _is_dissolving = true

