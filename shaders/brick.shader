shader_type canvas_item;

uniform float motion_factor : hint_range(0.00,0.05);

uniform float random_offset : hint_range(0.0,3.0);


void fragment(){
	
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME+random_offset) * motion_factor;
	waves_uv_offset.y = sin(TIME+random_offset) * motion_factor;
	
	COLOR = texture(TEXTURE, UV + waves_uv_offset);
	
	COLOR.a *= 0.5 ;
	//COLOR = vec4(tiled_uvs,0.0,1.0);
	}
	

	