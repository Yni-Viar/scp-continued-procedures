shader_type spatial;

//Made by rrh
//Licensed under CC0

uniform sampler2D normal:hint_normal;
uniform vec3 base_colour:source_color = vec3(0.5, 0.5, 0.5);

uniform vec3 snow_colour : source_color = vec3(0.9, 1.0, 1.0);

uniform float snow_ammount = 0.2;
uniform float snow_softness = 10.0;


// converts two-channel normal map into proper vector
vec3 convert_normal_map(vec2 normal_sample) {
	vec3 result;
	result.xy = normal_sample * 2.0 - 1.0;
    result.z = sqrt(1.0 - dot(result.xy, result.xy));
	return result;
}

void fragment() {
	// snow mask based on normal map
	vec4 normal_map = texture(normal, UV * 3.0);
    vec3 normal_map_vector = convert_normal_map(normal_map.rg);
    vec3 viewspace_normal = normalize(TANGENT * normal_map_vector.r + BINORMAL * normal_map_vector.g + NORMAL * normal_map_vector.b);
    vec3 world_normal = (INV_VIEW_MATRIX * vec4(viewspace_normal, 0.0)).xyz;
    vec3 up = vec3(0, 1, 0);
    float mapped_snow_mask = smoothstep(0.0, 1.0 - snow_ammount, dot(world_normal, up));
	mapped_snow_mask = pow(mapped_snow_mask, snow_softness);

	// snow mask based on vertex normal
	world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
	float vertex_snow_mask = smoothstep(0.0, 1.0 - snow_ammount, dot(world_normal, up));
	vertex_snow_mask = pow(vertex_snow_mask, snow_softness);

	// get higher of both
	float snow_mask = max(vertex_snow_mask, mapped_snow_mask);

    ALBEDO = mix(base_colour, snow_colour, snow_mask);
	NORMAL_MAP = mix(normal_map.rgb, vec3(0.5), snow_mask); // snow smooths out normals
}
