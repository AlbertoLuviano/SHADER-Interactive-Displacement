shader_type spatial;

uniform vec2 uCenter;
uniform float uRadius;
uniform float uOffsetFactor;

uniform sampler2D textureColor;

void vertex(){
	VERTEX.y += clamp((clamp(distance(VERTEX.xz, uCenter), 0.0, uRadius) / uRadius) * uOffsetFactor, uOffsetFactor * 0.5, uOffsetFactor) - uOffsetFactor;
}

void fragment(){
	ALBEDO = texture(textureColor, UV).xyz;
}
