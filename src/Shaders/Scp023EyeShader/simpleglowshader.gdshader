shader_type spatial;
//Made by Yni, license - CC0.

uniform vec3 color: source_color;
uniform float emission_strength;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = color;
	EMISSION = color * emission_strength;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
