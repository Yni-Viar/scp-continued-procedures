extends MeshInstance3D

@export var waypoints_and_groups: Dictionary[String, String] = {}
## Indexes starts with 0 - 0 means 1 word per line, 1 means 2 words per line.
@export var delimiter_after: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mesh is TextMesh:
		call_deferred("waypoint_add")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func waypoint_add():
	var index: int = 0
	for waypoint in waypoints_and_groups:
		if get_tree().has_group(waypoints_and_groups[waypoint]):
			mesh.text += waypoint + ' '
			index += 1
			if index > delimiter_after:
				mesh.text += '\n'
				index = 0
