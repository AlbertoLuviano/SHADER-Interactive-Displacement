extends RigidBody

export var torque : float = 100.0
export var simpleShaderP : NodePath
export var UVShaderP : NodePath
export var PosShaderP : NodePath
export var infoPath : NodePath

var simpleShaderNode
var uVShaderNode
var posShaderNode
var hexUnits
var infoNode

func _ready():
	hexUnits = get_tree().get_nodes_in_group("hexUnits")
	simpleShaderNode = get_node(simpleShaderP)
	uVShaderNode = get_node(UVShaderP)
	posShaderNode = get_node(PosShaderP)
	infoNode	 = get_node(infoPath)

func _integrate_forces(_state):
	add_torque(Vector3(Input.get_action_strength("Back") - Input.get_action_strength("Forward"), \
		0.0, Input.get_action_strength("Left") - Input.get_action_strength("Right")))

func _physics_process(_delta):
	updateCenter(Vector2(translation.x, translation.z))
	if (Input.is_action_just_pressed("InfoTrigger")):
		infoNode.visible = !infoNode.visible

func updateCenter(newCenter : Vector2):
	for hexUnit in hexUnits:
		hexUnit.effectCenter = newCenter
	simpleShaderNode.get_surface_material(0).set_shader_param("uCenter", \
		newCenter - Vector2(simpleShaderNode.translation.x, simpleShaderNode.translation.z))
	posShaderNode.get_surface_material(0).set_shader_param("uPosCenter", \
		Vector2(newCenter.x, -newCenter.y) - Vector2(posShaderNode.translation.x, posShaderNode.translation.z))
	
	var UVCoords : Vector2 = Vector2(0,0)
	UVCoords.x = (newCenter.x - uVShaderNode.translation.x) / 6.95
	UVCoords.y = (-newCenter.y - uVShaderNode.translation.z) / 5.23
	uVShaderNode.get_surface_material(0).set_shader_param("uUVCenter", UVCoords)
