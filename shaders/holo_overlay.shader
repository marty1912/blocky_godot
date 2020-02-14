shader_type canvas_item;
render_mode unshaded;


uniform sampler2D displace_image : hint_albedo;
uniform float displace_amt : hint_range(0,0.1);
uniform float displace_size : hint_range(0.1,2.0);
uniform float abberation_amt_x : hint_range(0,0.1);
uniform float abberation_amt_y : hint_range(0,0.1);

uniform sampler2D holo_lines : hint_albedo;
uniform float brightness : hint_range(0,0.1);
uniform float lines_size : hint_range(0.1,1.0);

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){
	// get random num between 0 and 1 
	float random_num = rand(vec2(TIME,0.0));
	int random_num_int = int(random_num);
	random_num = random_num - float(random_num_int);
	
	
	// displace effect
	vec4 disp = texture(displace_image,SCREEN_UV*displace_size*random_num);
	vec2 new_uv = SCREEN_UV + disp.xy * displace_amt*random_num;
	
	// abberation
	COLOR.r = texture(SCREEN_TEXTURE,new_uv - vec2(abberation_amt_x,abberation_amt_y)*random_num).r;
	COLOR.g = texture(SCREEN_TEXTURE,new_uv).g;
	COLOR.b = texture(SCREEN_TEXTURE,new_uv+ vec2(abberation_amt_x,abberation_amt_y) * random_num).b;
	COLOR.a = texture(SCREEN_TEXTURE,new_uv).a;
	float size = (abs(sin(TIME))*0.5)+0.5;
	COLOR.rgb += texture(holo_lines,SCREEN_UV*size).rgb * brightness;
	}
	
	