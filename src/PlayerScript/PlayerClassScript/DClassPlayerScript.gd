extends HumanPuppetScript
## Made by Yni, licensed under MIT license.

# Called when the node enters the scene tree for the first time.
func on_start_human() -> void:
	if Settings.current_season == Settings.Season.HALLOWEEN:
		$HumanRig/Skeleton3D/HeadAttachment/Pumpkin2.show()
	else:
		$HumanRig/Skeleton3D/HeadAttachment/Pumpkin2.hide()
