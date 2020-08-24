shader_type spatial;

uniform vec2 uFirstCenter;
uniform vec2 uCentersOffset;
uniform vec2 uGridSize;

uniform vec2 uPosCenter;
uniform float uRadius;
uniform float uOffsetFactor;

uniform sampler2D hexTexture;

void vertex(){
	float centerToUse = -1.0;
	float closestCenterDistance = 1000000.0;
	
	for(int n = 0; n < (int(uGridSize.x) * int(uGridSize.y)); n++){
		vec2 calculatedCenter = vec2(uFirstCenter.x + (uCentersOffset.x * mod(float(n), uGridSize.x)),
			uFirstCenter.y + (uCentersOffset.y * mod(float(n), 2.0)) + (floor(float(n) / uGridSize.x) * (2.0 * uCentersOffset.y)));
			
		if (distance(vec2(VERTEX.x, -VERTEX.z), vec2(calculatedCenter.x, calculatedCenter.y)) < closestCenterDistance){
			centerToUse = float(n);
			closestCenterDistance = distance(vec2(VERTEX.x, -VERTEX.z), vec2(calculatedCenter.x, calculatedCenter.y));
		}
	}
	
	vec2 centerToUseVec2 = vec2(uFirstCenter.x + (uCentersOffset.x * mod(centerToUse, uGridSize.x)),
		uFirstCenter.y + (uCentersOffset.y * mod(centerToUse, 2.0)) + (floor(centerToUse / uGridSize.x) * (2.0 * uCentersOffset.y)));
	
	VERTEX.y += clamp((clamp(distance(centerToUseVec2, uPosCenter), 0.0, uRadius) / uRadius) * uOffsetFactor, uOffsetFactor * 0.5, uOffsetFactor) - uOffsetFactor;
}

void fragment(){
	ALBEDO = texture(hexTexture, UV).xyz;
}