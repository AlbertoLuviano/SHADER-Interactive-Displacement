extends Camera

export var targetP : NodePath
export var cameraOffset : Vector3 = Vector3(0.0, 10.0, 12.0)

var targetNode

func _ready():
	targetNode = get_node(targetP)

func _process(_delta):
	translation = targetNode.translation + cameraOffset
