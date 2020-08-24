extends MeshInstance

export var radius : float = 1.0
export var offsetFactor : float = 2.0
export var effectCenter : Vector2

func _ready():
	var n : float = float(self.name.substr(7, 3))
	translation.x = 0.28 + (0.43 * fmod(n, 16.0))
	translation.z = -(0.25 + (0.25 * fmod(n, 2.0)) + (floor(n / 16.0) * (2.0 * 0.25)))

func _process(_delta):
	translation.y = clamp((clamp(Vector2(translation.x, translation.z).distance_to(effectCenter), 0.0, radius) / radius) \
		* offsetFactor, offsetFactor * 0.5, offsetFactor) - offsetFactor
