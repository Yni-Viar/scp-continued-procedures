shader_type spatial;

//Made by Unhinged Dev
//License: CC0
//Edited by Yni.

uniform lowp sampler2D screen_texture : hint_screen_texture, filter_nearest_mipmap, repeat_enable;
uniform lowp float alpha : hint_range(0.0, 1.0);

uniform lowp float red_shift;
uniform lowp float blue_shift;
uniform lowp float green_shift;

uniform lowp float red_mult = 1;
uniform lowp float blue_mult = 1;

void fragment() {
	vec2 uvs = SCREEN_UV;
	//vec4 final_texture  = texture(screen_texture, uvs);
	
	float r = texture(screen_texture, uvs + vec2((1.0 / VIEWPORT_SIZE) * red_shift), 0.0).r * red_mult;
	float g = texture(screen_texture, uvs + vec2((1.0 / VIEWPORT_SIZE) * green_shift), 0.0).g;
	float b = texture(screen_texture, uvs + vec2((1.0 / VIEWPORT_SIZE) * blue_shift), 0.0).b * blue_mult;
	
	ALBEDO = vec3(r, g, b);
}