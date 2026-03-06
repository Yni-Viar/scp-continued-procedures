extends Node3D
## Show when it is current season
## Made by Yni, licensed under MIT License.
class_name SeasonSwitcher

@export var current_season: Settings.Season

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.season_feature_checker(current_season):
		show()
	else:
		hide()
