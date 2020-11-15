shader_type spatial;

uniform vec2 uFirstCenter;
uniform vec2 uCentersOffset;

uniform vec2 uPosCenter;
uniform float uRadius;
uniform float uOffsetFactor;

uniform sampler2D hexTexture;

float when_gt(float x, float y) {
  return max(sign(x - y), 0.0);
}

float when_lt(float x, float y) {
  return max(sign(y - x), 0.0);
}

float when_eq(float x, float y) {
  return 1.0 - abs(sign(x - y));
}

void vertex(){
	float closestColumn = round(( VERTEX.x - uFirstCenter.x) / uCentersOffset.x);
	float closestRow = round((-VERTEX.z - uFirstCenter.y) / uCentersOffset.y);
	
	vec2 closestGridCenter = vec2(
		uFirstCenter.x + (closestColumn * uCentersOffset.x),
		uFirstCenter.y + (closestRow    * uCentersOffset.y)
	);
	
	closestRow    += 1.0 * when_gt(-VERTEX.z, closestGridCenter.y);
	closestRow    -= 1.0 * when_lt(-VERTEX.z, closestGridCenter.y);
	closestColumn += 1.0 * when_gt( VERTEX.x, closestGridCenter.x) * when_eq(-VERTEX.z, closestGridCenter.y);
	closestColumn -= 1.0 * when_lt( VERTEX.x, closestGridCenter.x) * when_eq(-VERTEX.z, closestGridCenter.y);
		
	vec2 centerToUseVec2 = vec2(
		uFirstCenter.x + (closestColumn * uCentersOffset.x),
		uFirstCenter.y + (closestRow    * uCentersOffset.y)
	);
	
	VERTEX.y += clamp((clamp(distance(centerToUseVec2, uPosCenter), 0.0, uRadius) / uRadius) * uOffsetFactor, uOffsetFactor * 0.5, uOffsetFactor) - uOffsetFactor;
}

void fragment(){
	ALBEDO = texture(hexTexture, UV).xyz;
}