extends BasicSeason
## Spawn when it is current season
## Made by Yni, licensed under MIT License.
class_name SeasonSpawner

@export var season_prefab: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.season_feature_checker(current_season):
		var node: Node3D = season_prefab.instantiate()
		add_child(node)
