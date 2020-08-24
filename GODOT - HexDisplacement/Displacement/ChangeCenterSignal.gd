extends Spatial

export var centerEffect : Vector2

func _process(_delta):
	if Input.is_action_pressed("Right"):
		centerEffect += Vector2(0.1, 0.0)
		updateCenter(centerEffect)
	elif Input.is_action_pressed("Left"):
		centerEffect += Vector2(-0.1, 0.0)
		updateCenter(centerEffect)
	elif Input.is_action_pressed("Forward"):
		centerEffect += Vector2(0.0, -0.1)
		updateCenter(centerEffect)
	elif Input.is_action_pressed("Back"):
		centerEffect += Vector2(0.0, 0.1)
		updateCenter(centerEffect)

func updateCenter(newCenter : Vector2):
	var hexUnits = get_tree().get_nodes_in_group("hexUnits")
	for hexUnit in hexUnits:
		hexUnit.effectCenter = newCenter
