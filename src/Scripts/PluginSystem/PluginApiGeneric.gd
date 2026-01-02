extends Node

var players: Array[PluginApiMovableNpc] = []

func update_players():
	players.clear()
	for node in get_tree().get_nodes_in_group("Players"):
		if !node.get_path().is_empty():
			players.append(node.get_node("PluginSystem"))

func get_player_by_index(index: int) -> PluginApiMovableNpc:
	if players[index] == null:
		printerr("This puppet does not exist. Returning local player...")
		update_players()
		for puppet in players:
			if puppet.is_player():
				return puppet
		printerr("Local player does not exist. Returning null...")
		return null
	else:
		return players[index]
