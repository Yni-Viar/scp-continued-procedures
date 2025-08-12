extends Area3D

@export var detect_scp347_with_mtf: bool = true
var agent_scp347: String = ""

func _on_body_entered(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.puppet_class_name == "SCP-347":
			if agent_scp347 != null && !agent_scp347.is_empty() && detect_scp347_with_mtf:
				get_tree().root.get_node("Game/FoundationTask").do_task("task_347")
				body.queue_free()
				get_node(agent_scp347).queue_free()
			else:
				get_tree().root.get_node("Game").finish_game(false, "GAME_OVER_2")
		elif body.puppet_class.puppet_class_name == "MTF_AGENT":
			agent_scp347 = body.get_path()

func _on_body_exited(body: Node3D) -> void:
	if body is MovableNpc:
		if body.puppet_class.puppet_class_name == "MTF_AGENT":
			agent_scp347 = ""
