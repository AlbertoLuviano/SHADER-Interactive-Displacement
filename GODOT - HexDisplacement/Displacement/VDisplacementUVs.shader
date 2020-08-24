shader_type spatial;

uniform vec2 uGridSize;
uniform vec2 uUVCenter;
uniform float uOffsetFactor;
uniform float uRadius : hint_range(0.1, 1.0, 0.01);

uniform sampler2D textureColor; //Unfortunately, it can't be easily assigned to obj files T___T

void vertex(){
	vec2 squashedUV;
	squashedUV = (floor(UV / (1.0 / uGridSize)) * 1.0 / uGridSize) + (1.0 / (uGridSize * 2.0));
	squashedUV.y = 1.0 - squashedUV.y;
	VERTEX.y += clamp((clamp(distance(squashedUV, uUVCenter), 0.0, uRadius) / uRadius) * uOffsetFactor, uOffsetFactor * 0.5, uOffsetFactor) - uOffsetFactor;
}

void fragment(){
//	ALBEDO = texture(textureColor, UV2).xyz; //Needs a secondary set of UVs, but obj doesn't support them. T___T
	ALBEDO = vec3(0.18, 0.4, 0.7);
}