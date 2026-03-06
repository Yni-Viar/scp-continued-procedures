extends ItemSpawner
## Spawn when it is current season
## Made by Yni, licensed under MIT License.
class_name SeasonSpawner

@export var current_season: Settings.Season

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.season_feature_checker(current_season) && get_tree().root.get_node("Game").rng.randf_range(0.0, 1.0) < chance && item != null:
		var prefab: Node3D = item.instantiate()
		add_child(prefab)
