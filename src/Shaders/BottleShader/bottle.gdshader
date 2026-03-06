/*
MIT License

Copyright (c) 2020 Lexpartizan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

shader_type spatial;
render_mode cull_disabled,shadows_disabled;

uniform vec2 coeff; // Coefficients of the linear function for the surface.
uniform float fill_amount;
uniform vec2 size;
uniform float glass_thickness;
uniform float scale;
uniform float wave_intensity = 0.05f;
uniform vec4 liquid_color: source_color;
uniform sampler2D waves_noise;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

varying lowp vec3 pos;
varying lowp float rot_scale;
varying lowp vec3 world_vec_up_to_model;
varying lowp vec3 weights;



void vertex() {
	/* Move vertices inwards to simulate glass thickness. */
	VERTEX -= glass_thickness * NORMAL;
	/* Position inside container rotated to world. */
	pos = mat3(MODEL_MATRIX)*VERTEX;
	/* Lerp between height and width depending on world orientation of z axis. */
	//rot_scale = mix(size.x, size.y, abs(dot(vec3(WORLD_MATRIX[0][1], WORLD_MATRIX[1][1], WORLD_MATRIX[2][1]), vec3(0.0f, 1.0f, 0.0f))));
	world_vec_up_to_model = vec3(0.0f, 1.0f, 0.0f)* mat3(MODEL_MATRIX);
	rot_scale = mix(size.x, size.y, abs(dot(world_vec_up_to_model, vec3(0.0f, 1.0f, 0.0f))));
	weights = mat3(MODEL_MATRIX)*NORMAL; weights*=weights;
}

void fragment() {
	/* Set liquid line to fill amount, add noise waves and incline. */
	lowp float wave_noise_1 = texture(waves_noise, (2.0*pos.xz + 0.5*TIME * vec2(1.0, 1.0))*scale).r;
	lowp float wave_noise_2 = texture(waves_noise, (2.0*pos.xz - 0.5*TIME * vec2(1.0, 1.0))*scale).g;
	lowp float wave = wave_intensity * length(coeff) * (wave_noise_1 - 0.5f + wave_noise_2 - 0.5f) + dot(pos.xz, coeff);
	wave *= smoothstep(0.05,0.25,fill_amount);
	lowp float liquid_line = (fill_amount*2.0-1.0+wave)*rot_scale;
	if (pos.y > liquid_line) discard;// Discard all vertices above the liquid line. */
	NORMAL = vec3(0.0, 1.0f, 0.0);
	ALBEDO = mix (texture(SCREEN_TEXTURE,SCREEN_UV - coeff*0.1 - (wave_noise_1)*0.01,liquid_color.a*2.0).rgb * (1.0 - liquid_color.a),liquid_color.xyz,liquid_color.a);
}

void light()
{
	// Liquid "glow" when held against light.
	lowp float d = dot(-VIEW, LIGHT);
	lowp float dd = smoothstep(0.0,1.0,d);
	//dd+=1.0;
	dd*=dd;
	DIFFUSE_LIGHT = dd*liquid_color.rgb;
}