shader_type canvas_item;
render_mode blend_add;

uniform vec4 glow_color : source_color = vec4(1.0, 0.85, 0.25, 1.0);
uniform float intensity : hint_range(0.0, 4.0, 0.01) = 2.0;

void fragment() {
	float alpha = texture(TEXTURE, UV).a;
	alpha = pow(alpha, 1.4);
	COLOR = vec4(glow_color.rgb, alpha * glow_color.a * intensity);
}
