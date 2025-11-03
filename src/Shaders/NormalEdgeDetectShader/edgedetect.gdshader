shader_type spatial;
render_mode unshaded, depth_test_disabled;
/*
	Made by nuzcraft
	The shader code and all code snippets in this post are under CC0 license
	and can be used freely without the author's permission.

	Edited by Yni for simplifying the shader.
*/

//#define LINE_ART

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform vec3 line_color: source_color = vec3(1.0, 1.0, 1.0);

#if CURRENT_RENDERER == RENDERER_FORWARD_PLUS && defined(LINE_ART)
uniform sampler2D NORMAL_TEXTURE : hint_normal_roughness_texture, filter_linear_mipmap;

uniform float edge_threshold = 0.2;
uniform vec3 background_color: source_color = vec3(0.0, 0.0, 0.0);
#endif

const mat2 robert_y = mat2(
	vec2(0.0, 1.0),
	vec2(-1.0, 0.0)
);

const mat2 robert_x = mat2(
	vec2(1.0, 0.0),
	vec2(0.0, -1.0)
);

#if CURRENT_RENDERER == RENDERER_FORWARD_PLUS && defined(LINE_ART)
vec3 normalize_normal(vec3 normal){
	return normalize(normal);
}
#endif

void vertex(){
	//POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 screen_color = texture(SCREEN_TEXTURE, uv);
#if CURRENT_RENDERER == RENDERER_FORWARD_PLUS && defined(LINE_ART)
	vec3 normal = texture(NORMAL_TEXTURE, uv).rgb;
	normal = normal * 2.0 - 1.0;
#endif
	vec2 offset = 1.0 / VIEWPORT_SIZE;

#if CURRENT_RENDERER == RENDERER_FORWARD_PLUS && defined(LINE_ART)
	vec3 nw = normalize_normal(texture(NORMAL_TEXTURE, uv + vec2(-offset.x, -offset.y)).rgb);
	vec3 ne = normalize_normal(texture(NORMAL_TEXTURE, uv + vec2(offset.x, -offset.y)).rgb);
	vec3 sw = normalize_normal(texture(NORMAL_TEXTURE, uv + vec2(-offset.x, offset.y)).rgb);
	vec3 se = normalize_normal(texture(NORMAL_TEXTURE, uv + vec2(offset.x, offset.y)).rgb);

	mat2 surrounding_pixels = mat2(
		vec2(length(nw - normal), length(ne - normal)),
		vec2(length(sw - normal), length(se - normal))
	);
#else
	vec3 nw = texture(SCREEN_TEXTURE, uv + vec2(-offset.x, -offset.y)).rgb;
	vec3 ne = texture(SCREEN_TEXTURE, uv + vec2(offset.x, -offset.y)).rgb;
	vec3 sw = texture(SCREEN_TEXTURE, uv + vec2(-offset.x, offset.y)).rgb;
	vec3 se = texture(SCREEN_TEXTURE, uv + vec2(offset.x, offset.y)).rgb;

	mat2 surrounding_pixels = mat2(
		vec2(length(nw), length(ne)),
		vec2(length(sw), length(se))
	);
#endif

	float edge_x = dot(robert_x[0], surrounding_pixels[0]) + dot(robert_x[1], surrounding_pixels[1]);
	float edge_y = dot(robert_y[0], surrounding_pixels[0]) + dot(robert_y[1], surrounding_pixels[1]);

	float edge = sqrt(pow(edge_x, 2.0)+pow(edge_y, 2.0));

#if CURRENT_RENDERER == RENDERER_FORWARD_PLUS && defined(LINE_ART)
	if (edge > edge_threshold) {
		ALBEDO = line_color;
	} else {
		ALBEDO = background_color;
	}
#else
	ALBEDO = vec3(edge * line_color);
#endif
}
