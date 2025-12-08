shader_type spatial;
render_mode unshaded;

//Made by Yni
//License: CC0

uniform sampler2D screen_texture: hint_screen_texture;
uniform sampler2D noise_texture: source_color, repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 noise = texture(noise_texture, UV + vec2(TIME * 0.1, 0.0));
	ALBEDO = texture(screen_texture, SCREEN_UV).rgb * noise.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
