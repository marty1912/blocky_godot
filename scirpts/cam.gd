extends Camera2D

#copied the shake code from the interweb
        # Animate this to increase/decrease/fade the shaking
var shake_amount = 0.00

func _process(delta):
    set_offset(Vector2( \
        rand_range(-1.0, 1.0) * shake_amount, \
        rand_range(-1.0, 1.0) * shake_amount \
    ))
    shake_amount *= 0.9
    
    if shake_amount < 0.01:
        shake_amount = 0
    
func shake():
    shake_amount = 100
    $Player.play()