shader_type spatial;
render_mode cull_disabled;

// Made by Yni.
// Licensed under CC0

uniform sampler2D lightning_textures[11];

float random(vec2 uv) {
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex = texture(lightning_textures[int(TIME * 24.) % 11], UV);
	ALBEDO = tex.rgb;
	EMISSION = tex.rgb;
	ALPHA = tex.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
