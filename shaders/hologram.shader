shader_type canvas_item;



uniform sampler2D displace_image : hint_albedo;
uniform sampler2D holo_lines : hint_albedo;
uniform sampler2D dissolve_img : hint_albedo;

uniform float dissolve_val : hint_range(0,1.0);

uniform float displace_amt : hint_range(0,0.05);
uniform float displace_size : hint_range(0,1.0);
uniform float abberation_amt_x : hint_range(0,0.01);
uniform float abberation_amt_y : hint_range(0,0.01);
uniform vec4 color : hint_color;

uniform float brightness : hint_range(0,1.0);
uniform float lines_size : hint_range(0,1.0);
uniform float alpha : hint_range(0,1.0);

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){
	// get random num between 0 and 1 
	float random_num = rand(vec2(TIME,0.0));
	int random_num_int = int(random_num);
	random_num = random_num - float(random_num_int);
	
	
	
	// displace effect (get changed uv)
	vec4 disp = texture(displace_image,UV*displace_size*random_num);
	vec2 new_uv = UV + disp.xy * displace_amt*random_num;
	
	// dissolve
    vec4 noise_texture = texture(dissolve_img, new_uv);
    // modify the main texture's alpha using the noise texture
    float alpha_factor = floor(dissolve_val + min(0.99, noise_texture.x));
	
	// abberation
	COLOR.r = texture(TEXTURE,new_uv - vec2(abberation_amt_x,abberation_amt_y)*random_num).r;
	COLOR.g = texture(TEXTURE,new_uv).g;
	COLOR.b = texture(TEXTURE,new_uv+ vec2(abberation_amt_x,abberation_amt_y) * random_num).b;
	COLOR.a = texture(TEXTURE,new_uv).a;
	
	float size = (abs(sin(TIME))*0.5)+0.5;
	// lines
	COLOR.rgb += texture(holo_lines,UV*size).rgb * brightness;
	
	// alpha value
	COLOR.a = COLOR.a * alpha * ((random_num*0.2)+0.8) * alpha_factor;
	
	COLOR.rgb *= color.rgb;
	
	
	
	}
	
	