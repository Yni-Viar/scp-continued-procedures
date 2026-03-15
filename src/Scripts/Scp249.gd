extends InteractableStatic

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func interact(player: Node3D):
	if player is MovableNpc && global_position.distance_to(player.global_position) < 3.0:
		player.global_position = get_tree().get_nodes_in_group("Door")[rng.randi_range(0, get_tree().get_node_count_in_group("Door") - 1)].global_position
		if get_tree().root.get_node("Game/FoundationTask").has_task("task_249"):
			get_tree().root.get_node("Game/FoundationTask").do_task("task_249")
