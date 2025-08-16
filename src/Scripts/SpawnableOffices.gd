extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	office_spawner(get_tree().root.get_node("Game").gamedata.custom_left_scientists_offices, "res://Assets/Rooms/sublevels/ScientistsRooms/LODefault.tscn", "LOfficeSpawn")
	office_spawner(get_tree().root.get_node("Game").gamedata.custom_right_scientists_offices, "res://Assets/Rooms/sublevels/ScientistsRooms/RODefault.tscn", "ROfficeSpawn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Personal office spawner
func office_spawner(offices: Array[PackedScene], default_office_path: String, relative_path_to_spawn: String):
	var used_offices: PackedInt64Array = [-1, -1, -1, -1]
	var offices_amount: int = offices.size()
	for i in range(4):
		if offices_amount <= 0:
			var office_to_spawn: Node3D = load(default_office_path).instantiate()
			get_node(relative_path_to_spawn + str(i+1)).add_child(office_to_spawn)
		else:
			var random_office_id = get_tree().root.get_node("Game").rng.randi_range(0, offices.size() - 1)
			if !used_offices.has(random_office_id):
				used_offices[i] = random_office_id
				var office_to_spawn: Node3D = offices[random_office_id].instantiate()
				get_node(relative_path_to_spawn + str(i+1)).add_child(office_to_spawn)
				offices_amount -= 1
