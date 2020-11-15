shader_type spatial;

uniform sampler2D hexTexture;
uniform vec2 hexSize = vec2(0.56, 0.5);

uniform vec2 uPosCenter;
uniform float uRadius = 3.0;
uniform float uOffsetFactor = 5.0;

void vertex(){
	vec2 normalizedPos = vec2(0.0, 0.0);
	vec2 extendedNormalizedPos = vec2(0.0, 0.0);
	vec2 extendedRoundedPos = vec2(0.0, 0.0);
	vec2 distanceRoundToNormalized = vec2(0.0, 0.0);
	
	//Find an offset value (X)
	normalizedPos.x = VERTEX.x / hexSize.x;
	extendedNormalizedPos.x = normalizedPos.x / 0.25;
	extendedRoundedPos.x = round(normalizedPos.x / 0.25);
	distanceRoundToNormalized.x = extendedRoundedPos.x - extendedNormalizedPos.x;
	
	//Round values to square shape and add offset (X)
	vec2 roundedPosition = vec2(0.0, 0.0);
	roundedPosition.x = round(normalizedPos.x / 0.75);
	roundedPosition.x -= distanceRoundToNormalized.x;
	
	//Find center of the hexagon (X)
	vec2 hexCenter = vec2(0.0, 0.0);
	hexCenter.x = floor(roundedPosition.x) + 0.5;
	
	//Find even columns to offset y position -0.5
	vec2 nXY = vec2(0.0, 0.0);
	nXY.x = mod(hexCenter.x - 0.5, 2.0);
	
	//Normalize Y pos and find center
	normalizedPos.y = -VERTEX.z / hexSize.y;
	normalizedPos.y -= 0.5 * nXY.x;
	hexCenter.y = floor(normalizedPos.y) + 0.5;
	
	//Correct X position
	hexCenter.x -= (hexCenter.x - 0.5) * 0.25;
	
	//return to original scale
	hexCenter.x *= hexSize.x;
	hexCenter.y *= hexSize.y;
	
	VERTEX.y += clamp((clamp(distance(hexCenter, uPosCenter), 0.0, uRadius) / uRadius) * uOffsetFactor, uOffsetFactor * 0.5, uOffsetFactor) - uOffsetFactor;
}

void fragment(){
	vec3 originalRGB = texture(hexTexture, UV).rgb;
	float greyscale = min(max(originalRGB.r, originalRGB.g), originalRGB.b);
	originalRGB = vec3(greyscale);
	ALBEDO = vec3(((sin(TIME + UV.x) * 0.5) + 1.0) * originalRGB.r, ((sin(TIME - UV.y) * 0.5) + 1.0) * originalRGB.g, ((sin(TIME - 2.0*UV.x) * 0.5) + 1.0) * originalRGB.b);
}