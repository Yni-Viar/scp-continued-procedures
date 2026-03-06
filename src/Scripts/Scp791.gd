extends InteractableStatic
## SCP-791 task script
## Created by Yni, licensed under dual license: for SCP content - GPL 3, for non-SCP - MIT License

func interact(player: Node3D):
	if player.get_node("PlayerModel").get_child_count() > 0 && get_tree().root.get_node("Game/FoundationTask").has_task("task_791"):
		var puppet: BasePuppetScript = player.get_node("PlayerModel").get_child(0)
		if puppet is HumanPuppetScript:
			if puppet.current_item == 14:
				get_tree().root.get_node("Game/FoundationTask").do_task("task_791")
