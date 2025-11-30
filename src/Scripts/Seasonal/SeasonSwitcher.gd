extends Node3D
class_name SeasonSwitcher

@export var current_season: Settings.Season

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.current_season == current_season || \
	 current_season == Settings.Season.NONE && Settings.current_season <= 4:
		show()
	else:
		hide()
