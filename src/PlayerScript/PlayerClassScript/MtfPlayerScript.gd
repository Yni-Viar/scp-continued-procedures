extends HumanPuppetScript


## If the player is near, attack
var near_targets: bool = false
## Follow player if see.
var saw_player: bool = false
## Attack timer
var attack_update_timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func on_start_human() -> void:
	pass


func on_update_human(delta: float):
	if get_tree().get_node_count_in_group("ChaosInsurgency") > 0:
		if near_targets:
			attack()
		else:
			var collider = get_tree().get_first_node_in_group("ChaosInsurgency")
			if collider == null && get_tree().root.get_node("Game/FoundationTask").has_task("task_ci"):
				get_tree().root.get_node("Game/FoundationTask").trigger_event(0)
				get_tree().root.get_node("Game/UI/HBoxContainer/CallMtfButton").hide()
			else:
				if collider is MovableNpc:
					var puppet_class = collider.puppet_class
					if puppet_class.fraction == 0 && puppet_class.team == 3:
						if !get_parent().get_parent().movement_freeze:
							get_parent().get_parent().follow_target = collider.get_path()
	elif get_tree().get_node_count_in_group("ChaosInsurgency") == 0 && get_tree().root.get_node("Game/FoundationTask").has_task("task_ci"):
		get_tree().root.get_node("Game/FoundationTask").trigger_event(0)
		get_tree().root.get_node("Game/UI/HBoxContainer/CallMtfButton").hide()

func _on_raycast_update_npc(collider_path: String):
	var _collider_prefab: MovableNpc = get_node(collider_path)
	if _collider_prefab.puppet_class.fraction == 0 && _collider_prefab.puppet_class.team == 3:
		attack()

func attack():
	if attack_update_timer > 0:
		attack_update_timer -= get_physics_process_delta_time()
	else:
		var test = get_parent().get_parent().follow_target
		get_node(test).health_manage(-75.0)
		attack_update_timer = 0.5
