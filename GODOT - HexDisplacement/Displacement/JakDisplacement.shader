shader_type spatial;

uniform vec2 uFirstCenter;
uniform vec2 uCentersOffset;

uniform vec2 uPosCenter;
uniform float uRadius;
uniform float uOffsetFactor;

uniform sampler2D hexTexture;

void vertex(){
	float closestColumn = round(( VERTEX.x - uFirstCenter.x) / uCentersOffset.x);
	float closestRow = round((-VERTEX.z - uFirstCenter.y) / uCentersOffset.y);
	
	vec2 closestGridCenter = vec2(
		uFirstCenter.x + (closestColumn * uCentersOffset.x),
		uFirstCenter.y + (closestRow    * uCentersOffset.y)
	);
	
	if (-VERTEX.z > closestGridCenter.y) {
		closestRow    += 1.0;
	} else if (-VERTEX.z < closestGridCenter.y) {
		closestRow    -= 1.0;
	} else if ( VERTEX.x < closestGridCenter.x) {
		closestColumn -= 1.0;
	} else if ( VERTEX.x > closestGridCenter.x) {
		closestColumn += 1.0;
	}
	
	vec2 centerToUseVec2 = vec2(
		uFirstCenter.x + (closestColumn * uCentersOffset.x),
		uFirstCenter.y + (closestRow    * uCentersOffset.y)
	);
	
	VERTEX.y += clamp((clamp(distance(centerToUseVec2, uPosCenter), 0.0, uRadius) / uRadius) * uOffsetFactor, uOffsetFactor * 0.5, uOffsetFactor) - uOffsetFactor;
}

void fragment(){
	ALBEDO = texture(hexTexture, UV).xyz;
}