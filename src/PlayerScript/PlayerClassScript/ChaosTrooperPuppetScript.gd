extends HumanPuppetScript
## Chaos Insurgent Trooper puppet
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License

## If the player is near, attack
var near_targets: bool = false
## Follow player if see.
var saw_player: bool = false
## Attack timer
var attack_update_timer: float = 2.0

# Called when the node enters the scene tree for the first time.
func on_start_human() -> void:
	#Retrieve protagonist node path and make it follow target
	get_parent().get_parent().follow_target = get_tree().root.get_node("Game/StaticPlayer").target_puppet_path


func on_update_human(delta: float):
	if near_targets:
		attack()
	if !saw_player && raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is MovableNpc:
			var puppet_class = collider.puppet_class
			# Give player a chance, if CI came, to not entirely lose because of SCP-347 task.
			if puppet_class.fraction == 0 && puppet_class.team == 1 && puppet_class.puppet_class_name != "MTF_AGENT":
				saw_player = true
				if !get_parent().get_parent().movement_freeze:
					get_parent().get_parent().follow_target = collider.get_path()

func _on_raycast_update_npc(collider_path: String):
	var _collider_prefab: MovableNpc = get_node(collider_path)
	if _collider_prefab.puppet_class.fraction == 0 && _collider_prefab.puppet_class.team == 3:
		attack()

func attack():
	if attack_update_timer > 0:
		attack_update_timer -= get_physics_process_delta_time()
	else:
		var test = get_parent().get_parent().follow_target
		get_node(test).health_manage(-70.0)
		attack_update_timer = 0.625
