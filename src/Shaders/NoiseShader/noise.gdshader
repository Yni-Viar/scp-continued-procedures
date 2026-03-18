shader_type spatial;
//Made by Yni
//Licensed under CC0
render_mode unshaded;

float rand(vec2 co){
	return fract(sin(dot(co ,vec2(12.9898,78.233))) * 43758.5453);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float color = rand(SCREEN_UV);
	ALBEDO = vec3(clamp(color, 0.0, 0.5));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
