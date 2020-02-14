shader_type canvas_item;
render_mode unshaded;


uniform sampler2D displace_image : hint_albedo;
uniform sampler2D holo_lines : hint_albedo;
uniform sampler2D dissolve_img : hint_albedo;

uniform float dissolve_val =1;

uniform float displace_amt = 0.04 ;
uniform float displace_size =  0.359;
uniform float abberation_amt_x =0.035;
uniform float abberation_amt_y =0.035;

uniform float brightness =0.11;
uniform float lines_size =0.255;
uniform float alpha =0.85;

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
	
	
	
	}
	
	