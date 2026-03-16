extends HumanPuppetScript
## Chaos and MTF base scripts
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License
class_name AttackerPuppetScript

var timer: float = 10.0

func go_to_target(primary_target: String):
	get_parent().get_parent().follow_target = primary_target
	if !get_parent().get_parent().get_node("NavigationAgent3D").is_target_reachable():
		get_parent().get_parent().follow_target = get_tree().get_nodes_in_group("WavePointUpper")
		if !get_parent().get_parent().get_node("NavigationAgent3D").is_target_reachable():
			get_parent().get_parent().follow_target = get_tree().get_nodes_in_group("WavePointLower")
