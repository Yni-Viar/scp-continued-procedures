extends Node

enum EntityType {PUPPET, TASKS, ITEMS}

enum MapGenRoomType {
	ROOM1 = 0,
	ROOM1SINGLE = 1,
	ROOM1LARGE = 2,
	ROOM2 = 3,
	ROOM2SINGLE = 4,
	ROOM2LARGE = 5, 
	ROOM2C = 6,
	ROOM2CSINGLE = 7,
	ROOM2CLARGE = 8,
	ROOM3 = 10,
	ROOM3SINGLE = 11,
	ROOM3LARGE = 12,
	ROOM4 = 13,
	ROOM4SINGLE = 14}

const _MAPGEN_ROOM_TYPE_CONVERSION: Array[String] = [
	"endrooms",
	"endrooms_single",
	"endrooms_single_large",
	"hallways",
	"hallways_single",
	"hallways_single_large",
	"corners",
	"corners_single",
	"corners_single_large",
	"trooms",
	"trooms_single",
	"trooms_single_large",
	"crossrooms",
	"crossrooms_single"
]

var players: Array[PluginApiMovableNpc] = []

## Refreshes player/puppet list
func update_puppets():
	players.clear()
	for node in get_tree().get_nodes_in_group("Players"):
		if !node.get_path().is_empty():
			players.append(node.get_node("PluginSystem"))

## Gets puppet by index
## If puppet not found then gets local player
func get_puppet_by_index(index: int) -> PluginApiMovableNpc:
	if players[index] == null:
		printerr("This puppet does not exist. Returning local player...")
		update_puppets()
		for puppet in players:
			if puppet.is_player():
				return puppet
		printerr("Local player does not exist. Returning null...")
		return null
	else:
		return players[index]

## Spawns entity with selected by index resource.
## As of 6.0.0, only puppets are supported, so the first argument is always 0.
func spawn_entity(type: EntityType, index: int):
	match type:
		EntityType.PUPPET:
			get_tree().root.get_node("Game").spawn_npc_call(index)

## Loads new entity to the game
## As of 6.0.0, only items and tasks are supported, not puppets
func load_new_entity(type: EntityType, path: String):
	if path.contains("user://") || path.contains("res://"):
		match type:
			EntityType.TASKS:
				var task: GameTaskResource = ResourceStorage.load_resource(path, "GameTaskResource")
				get_tree().root.get_node("Game").gamedata.tasks.append(task)
				return get_tree().root.get_node("Game").gamedata.tasks.size() - 1
			EntityType.ITEMS:
				var item: Item = ResourceStorage.load_resource(path, "Item")
				if (item.gltf_path.contains("user://") || item.gltf_path.contains("res://")) && \
				 (item.pickup_sound_path.contains("user://") || item.pickup_sound_path.contains("res://") || item.pickup_sound_path.is_empty()) && \
				 (item.pickable_path.is_empty()):
					var pickable: Pickable = Pickable.new()
					pickable.add_child(Settings.load_gltf(item.gltf_path))
					var collider: CollisionShape3D = CollisionShape3D.new()
					collider.shape = BoxShape3D.new()
					collider.shape.size = item.collider_size
					var packed_scene:PackedScene = PackedScene.new()
					packed_scene.pack(pickable)
					ResourceSaver.save(packed_scene, "user://custom_content_prefabs/items/" + item.name + ".tscn")
					item.pickable_path = "user://custom_content_prefabs/items/" + item.name + ".tscn"
					pickable.queue_free()
					get_tree().root.get_node("Game").gamedata.items.append(item)
					return get_tree().root.get_node("Game").gamedata.items.size() - 1
				else:
					printerr("Wrong path name of item 3d model OR you have data in pickable_path, which is not permitted")
	else:
		printerr("Wrong path name of entity")

## Do task
func do_task(task_name: String):
	get_tree().root.get_node("Game/FoundationTask").do_task(task_name)

## Re-initialize tasks
## As of 6.0.0, this is a workaround for adding new task directly
func re_initialize_tasks(amount: int = 2):
	get_tree().root.get_node("Game/FoundationTask").initialize(amount)

## Adds new room to the map.
## Not compatible with Android devices and can only be an on_launch plugin.
## Double and checkpoint rooms are not supported
func load_new_room(path: String, zone_index: int, room_type: MapGenRoomType):
	if OS.get_name() != "Android" && get_tree().root.get_node("Game").map_generator_generated:
		if path.contains("user://") || path.contains("res://"):
			var room: MapGenRoom = ResourceStorage.load_resource(path, "MapGenRoom")
			if room.icon_0_degrees == null && room.icon_90_degrees == null && \
			 room.icon_180_degrees == null && room.icon_270_degrees == null && \
			 room.prefab == null && (room.gltf_path.contains("user://") || room.gltf_path.contains("res://")):
				#initializing the room
				var room_prefab: Node3D = Node3D.new()
				var loaded_gltf: NavigationRegion3D = Settings.load_gltf(room.gltf_path) as NavigationRegion3D
				loaded_gltf.bake_navigation_mesh()
				for node in loaded_gltf.get_children():
					if node is MeshInstance3D:
						node.create_trimesh_collision()
				#room_prefab.add_child()
				
				var packed_scene:PackedScene = PackedScene.new()
				packed_scene.pack(room_prefab)
				#ResourceSaver.save(packed_scene, "user://custom_content_prefabs/" + MapGenRoomType.keys()[room_type] + "/" + room.name + ".tscn")
				room.prefab = packed_scene
				# Loading zone array of converted zone values and add a new room into it
				var zone_array: Array[MapGenRoom] = get_tree().root.get_node("Game/FacilityGenerator").rooms[zone_index].get(_MAPGEN_ROOM_TYPE_CONVERSION[room_type])
				zone_array.append(room)
				get_tree().root.get_node("Game/FacilityGenerator").rooms[zone_index].set(_MAPGEN_ROOM_TYPE_CONVERSION[room_type], zone_array)
			else:
				printerr("Wrong path name of room 3d model OR you have data in icon_X_degrees or prefab, which is not permitted")
		else:
			printerr("Wrong path name of room resource")
	else:
		printerr("You are starting this function too late, OR you are trying to launch this function on Android")
