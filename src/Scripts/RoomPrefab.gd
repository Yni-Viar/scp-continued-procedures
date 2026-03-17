extends StaticBody3D
## Room prefab script
## Used by SCP-649
## Made by Yni, licensed under MIT License.
class_name RoomPrefab

@export_group("SCP-649 properties")
## SCP-649 - room mesh to fill with snow.
@export var mesh_node_path: NodePath
## SCP-649 - floor index
@export var floor_material_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
