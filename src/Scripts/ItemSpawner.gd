extends Marker3D
class_name ItemSpawner
## Made by Yni, licensed under MIT License.

## Target item to spawn
@export var item: PackedScene
## Chance to spawn
@export_range(0.0, 1.0, 0.0001) var chance: float = 0.33
@export_enum("Both Lite and Full", "Full only", "Lite only") var availability: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().root.get_node("Game").rng.randf_range(0.0, 1.0) < chance && item != null:
		var prefab: Node3D = item.instantiate()
		add_child(prefab)
