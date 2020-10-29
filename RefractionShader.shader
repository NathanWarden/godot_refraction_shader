shader_type spatial;

uniform vec4 tint : hint_color = vec4(1,1,1,0);
uniform float specular = 0.9;
uniform float roughness = 0.4;
uniform float metallic = 0.5;
uniform float strength = 1;
uniform bool use_normal_map = false;
uniform sampler2D normalmap;

void fragment()
{
	vec2 offset = SCREEN_UV;
	float xNorm = NORMAL.x;
	float yNorm = NORMAL.y;
	offset.x += NORMAL.z * xNorm * strength * 0.01;
	offset.y += NORMAL.z * yNorm * strength * -0.01;

	ALBEDO = ((texture(SCREEN_TEXTURE, offset).xyz * (1.0 - tint.a)) + (tint.xyz * tint.a)) / 2.0;
	SPECULAR = specular;
	ROUGHNESS = roughness;
	METALLIC = metallic;

	if (use_normal_map)
		NORMALMAP = texture(normalmap, UV).xyz;
}
