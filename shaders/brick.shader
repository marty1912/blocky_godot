shader_type canvas_item;

// export
uniform float time_factor = 1.0;

uniform vec2 amplitude = vec2(10.0,10.0);

uniform float motion_factor = 0.05;



void fragment(){
	//tiled_uvs.y *= aspect_ratio;
	//texture(TEXTURE, tiled_uvs);
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME) * motion_factor;
	waves_uv_offset.y = sin(TIME) * motion_factor;
	
	COLOR = texture(TEXTURE, UV + waves_uv_offset);
	
	COLOR.a *= 0.5 ;
	//COLOR = vec4(tiled_uvs,0.0,1.0);
	}
	
void vertex(){
	//VERTEX.x += cos(TIME*time_factor + VERTEX.x+VERTEX.y) * amplitude.x;
	//VERTEX.y += sin(TIME*time_factor + VERTEX.x+VERTEX.y) * amplitude.y;
	
	
	}
	